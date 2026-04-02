import 'dart:io';

import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/widget/drawer_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    setState(() => _messages.insert(0, textMessage));
    _fakeBotReply(message.text);
  }

  void _sendImage(String path) {
    final message = types.ImageMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      name: 'image',
      size: 0,
      uri: path,
    );
    setState(() => _messages.insert(0, message));
  }

  Future<void> _handleAttachmentPressed() async {
    final picker = ImagePicker();
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: theme.colorScheme.primary),
              title: Text('Camera', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () async {
                Navigator.pop(context);
                final image = await picker.pickImage(source: ImageSource.camera);
                if (image != null) _sendImage(image.path);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: theme.colorScheme.primary),
              title: Text('Gallery', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () async {
                Navigator.pop(context);
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) _sendImage(image.path);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fakeBotReply(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1));
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Bot reply to: $userMessage",
    );
    setState(() => _messages.insert(0, botMessage));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerChats(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: cs.onPrimary),
        ),
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: Icon(Icons.menu, color: cs.onPrimary, size: 30),
          ),
        ],
        toolbarHeight: 80,
        backgroundColor: cs.primary,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: maincolor,
                child: SvgPicture.asset('assets/Icon.svg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Assistant',
                    style: theme.appBarTheme.titleTextStyle,
                  ),
                  const Gap(5),
                  Text(
                    'Always active',
                    style: TextStyle(fontSize: 12, color: cs.onPrimary.withOpacity(0.8)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Chat(
        showUserAvatars: true,
        avatarBuilder: (author) => Padding(
          padding: const EdgeInsets.only(right: 5),
          child: CircleAvatar(
            
            backgroundColor: cs.primaryContainer,
            child: SvgPicture.asset(
              'assets/Icon.svg',
              color: cs.onPrimaryContainer,
            ),
          ),
        ),
        onAttachmentPressed: _handleAttachmentPressed,
        disableImageGallery: true,
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          attachmentButtonIcon: Icon(Icons.image, size: 30, color: cs.onSurfaceVariant),
          primaryColor: cs.primary,
          secondaryColor: cs.surfaceContainerHighest,
          sentMessageBodyTextStyle: TextStyle(
            color: cs.onPrimary,
            fontSize: 16,
          ),
          inputBackgroundColor: cs.surface,
          inputTextColor: cs.onSurface,
          inputBorderRadius: BorderRadius.circular(12),
          inputTextDecoration: InputDecoration(
            hintText: 'Ask about your crops...',
            hintStyle: TextStyle(color: cs.onSurfaceVariant),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
          ),
          sendButtonIcon: SvgPicture.asset(
            "assets/send-icon.svg",
            width: 24,
            height: 30,
            color: cs.primary,
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}