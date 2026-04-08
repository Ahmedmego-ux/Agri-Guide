import 'dart:convert';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/chat_bot/data/models/chat_session_model.dart';
import 'package:agri_guide_app/feature/chat_bot/data/models/message_model.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/entity/message_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/repos/chat_repo.dart';
import 'package:dartz/dartz.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepoImpl implements ChatRepo{
  final _supbase=Supabase.instance.client;
@override
Future<Either<String, String>> sendMessage(List<MessageEntity> messages) async {
  try {
    final session = _supbase.auth.currentSession;
    if (session == null || session.isExpired) {
      return const Left('Please login first');
    }
    
    // ✅ تجهيز الرسائل (دعم الصور)
    final preparedMessages = messages.map((e) {
      final msg = {
        'role': e.role,
        'content': e.content,
        'time': e.time?.toIso8601String(),
      };
      if (e.imageBase64 != null && e.imageBase64!.isNotEmpty) {
        msg['imageBase64'] = e.imageBase64;
      }
      return msg;
    }).toList();
    
    final response = await _supbase.functions.invoke(
      'chat',
      body: {'messages': preparedMessages},
    );
    
    final reply = _extractReply(response.data);
    
    print('========== DEBUG ==========');
    print('Response: ${response.data}');
    print('Reply: $reply');
    print('===========================');
    
    return reply != null 
        ? Right(reply)
        : const Left('No reply received from assistant');
        
  } on FunctionException catch (e) {
    print('Function error: $e');
    return Left('Server error: $e');
  } catch (e) {
    print('Unexpected error: $e');
    return const Left('An unexpected error occurred');
  }
}

String? _extractReply(dynamic data) {
  if (data == null) return null;
  
  if (data is Map<String, dynamic>) {
    // ✅ حاول استخراج الرد من مفاتيح متعددة
    for (var key in ['reply', 'message', 'text', 'response']) {
      if (data.containsKey(key) && data[key] != null) {
        return data[key].toString();
      }
    }
    return null;
  }
  
  if (data is String) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map) return _extractReply(decoded);
    } catch (_) {}
    return data;
  }
  
  return data.toString();
}

  @override
  Future<Either<String, ChatSessionEntity>> createSession(String title)async {
    final userId = _supbase.auth.currentUser!.id;
    
  try {
  final response=await  _supbase.from('chat_sessions').insert({
          'user_id': userId,
          'title': title,
        }).select()
        .single();

        return right(ChatSessionModel.fromJson(response));
} catch (e) {
 return left(ErrorHandler.handlePostgrestError(e.toString()));
}
  }

  @override
  Future<Either<String, List<MessageEntity>>> getMessages(String sessionId)async {
try {
  final response=  await _supbase.from('chat_messages').select()
     .eq('session_id', sessionId)
     .order('created_at', ascending: true);
final List<MessageEntity> messages=response.map<MessageEntity>((e)=>MessageModel.fromJson(e)).toList();
return right(messages);
} catch (e) {
  return left(ErrorHandler.handlePostgrestError(e.toString()));
}

  }

  @override
  Future<Either<String, List<ChatSessionEntity>>> getSessions()async {
     try {
  final userId = _supbase.auth.currentUser!.id;
 final response= await _supbase.from('chat_sessions').select()
     .eq('user_id', userId)
     .order('created_at', ascending: false);
final List<ChatSessionEntity> seasions=response.map((e) =>ChatSessionModel.fromJson(e) ,).toList();
     return right(seasions);
}  catch (e) {
   return left(ErrorHandler.handlePostgrestError(e.toString()));

  
}
  }
  
  @override
  Future<void> saveMessage(String sessionId, MessageEntity message) async{
    try {
  await _supbase.from('chat_messages')
  .insert({
    'session_id': sessionId,
      'role': message.role,
      'content': message.content,
      'image_url': message.imageBase64,
      'created_at': message.time.toIso8601String(),
  });
}  catch (e) {
    print('Error saving message: $e');
    // Optionally rethrow or handle based on your needs
    throw ErrorHandler.handlePostgrestError(e.toString());
}
  }


    @override
  Future<Either<String, void>> updateSessionTitle(String sessionId, String title) async {
    try {
      await _supbase.from('chat_sessions')
        .update({
          'title': title,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', sessionId);
      
      return const Right(null);
    } catch (e) {
      print('Error updating session title: $e');
      return Left(ErrorHandler.handlePostgrestError(e.toString()));
    }
  }
}