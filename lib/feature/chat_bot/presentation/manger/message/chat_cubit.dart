import 'package:agri_guide_app/feature/chat_bot/domain/entity/message_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.repo) : super(ChatInitial());
  final ChatRepo repo;

  final List<MessageEntity> _messages = [];
  final List<types.Message> uiMessages = [];
  String? sessionId;
  
  // ✅ متغيرات جديدة
  bool _isFirstMessage = true;

  static const _user = types.User(id: 'user');
  static const _bot = types.User(id: 'bot');

  Future<void> sendMessage({String? text, String? imageBase64}) async {
    if (state is ChatLoading) return;
    print('========== SEND MESSAGE ==========');
  print('Text: $text');
  print('ImageBase64 length: ${imageBase64?.length ?? 0}');
  print('ImageBase64 exists: ${imageBase64 != null}');
  print('===================================');

    // ✅ إذا كانت أول رسالة ولا توجد جلسة، أنشئ جلسة جديدة
    if (_isFirstMessage && sessionId == null && text != null) {
      final title = text.length > 30 ? '${text.substring(0, 30)}...' : text;
      
      final result = await repo.createSession(title);
      result.fold(
        (error) {
          emit(ChatFaliure(error));
          return;
        },
        (newSession) {
          sessionId = newSession.id;
        },
      );
    }

    // ✅ أضف رسالة المستخدم في الـ UI
    final tempId = const Uuid().v4();
    if (text != null) {
      uiMessages.insert(0, types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: tempId,
        text: text,
      ));
    } else if (imageBase64 != null) {
      uiMessages.insert(0, types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: tempId,
        name: 'image',
        size: 0,
        uri: imageBase64,
      ));
    }

    // ✅ أضف loading
    uiMessages.insert(0, types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'loading',
      text: '...',
    ));

    emit(ChatLoading());

    final userMessage = MessageEntity(
      role: 'user',
      content: text,
      imageBase64: imageBase64,
      time: DateTime.now(),
    );
    _messages.add(userMessage);

    if (sessionId != null) {
      await repo.saveMessage(sessionId!, userMessage);
    }

    final result = await repo.sendMessage(_messages);

    result.fold(
      (error) {
        uiMessages.removeWhere((m) => m.id == 'loading');
        emit(ChatFaliure(error));
      },
      (reply) async {
        final botMessage = MessageEntity(
          role: 'assistant',
          content: reply,
          time: DateTime.now(),
        );
        _messages.add(botMessage);

        if (sessionId != null) {
          await repo.saveMessage(sessionId!, botMessage);
        }

        // ✅ شيل loading وحط الرد
        uiMessages.removeWhere((m) => m.id == 'loading');
        uiMessages.insert(0, types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: reply,
        ));

        // ✅ بعد أول رسالة، قم بتحديث عنوان الجلسة (تأكيد)
        if (_isFirstMessage && text != null && sessionId != null) {
          _isFirstMessage = false;
          final finalTitle = text.length > 30 ? '${text.substring(0, 30)}...' : text;
          await repo.updateSessionTitle(sessionId!, finalTitle);
        }

        emit(ChatSuccess(reply));
      },
    );
  }

  Future<void> loadMessages(String sId) async {
    // ✅ حفظ الجلسة الحالية قبل التبديل
    await _saveCurrentSessionTitle();
    
    sessionId = sId;
    _messages.clear();
    uiMessages.clear();
    _isFirstMessage = false; // ليست أول رسالة
    emit(ChatLoading());

    final result = await repo.getMessages(sId);
    result.fold(
      (error) => emit(ChatFaliure(error)),
      (messages) {
        _messages.addAll(messages);
        uiMessages.addAll(messages.reversed.map((msg) {
          return types.TextMessage(
            author: msg.role == 'user' ? _user : _bot,
            createdAt: msg.time.millisecondsSinceEpoch,
            id: msg.time.toIso8601String(),
            text: msg.content ?? '',
          );
        }));
        emit(ChatSuccess(''));
      },
    );
  }

  // ✅ دالة مساعدة لحفظ عنوان الجلسة الحالية
  Future<void> _saveCurrentSessionTitle() async {
    if (sessionId != null && _messages.isNotEmpty) {
      final firstUserMessage = _messages.firstWhere(
        (msg) => msg.role == 'user',
        orElse: () => MessageEntity(role: '', content: '', time: DateTime.now()),
      );
      
      if (firstUserMessage.content != null && firstUserMessage.content!.isNotEmpty) {
        final title = firstUserMessage.content!.length > 30 
            ? '${firstUserMessage.content!.substring(0, 30)}...' 
            : firstUserMessage.content!;
        
        await repo.updateSessionTitle(sessionId!, title);
      }
    }
  }

  // ✅ تعديل startNewChat لحفظ الشات القديم
  Future<void> startNewChat() async {
    // حفظ الجلسة الحالية قبل إنشاء جلسة جديدة
    await _saveCurrentSessionTitle();
    
    // إعادة تعيين المتغيرات للجلسة الجديدة
    sessionId = null;
    _messages.clear();
    uiMessages.clear();
    _isFirstMessage = true;
    emit(ChatInitial());
  }
}