import 'dart:convert';
import 'dart:io';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/message/chat_cubit.dart' as chat_cubit;
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/session/session_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/widget/drawer_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');

 
 

  Future<void> _handleSendPressed(types.PartialText message) async {
    if (message.text.trim().isEmpty) return;
    await context.read<chat_cubit.ChatCubit>().sendMessage(text: message.text);
    context.read<SessionCubit>().getSessions();
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerChats(),
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
                backgroundColor: cs.primaryContainer,
                child: SvgPicture.asset(
                  'assets/Icon.svg',
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Assistant',
                    style: theme.appBarTheme.titleTextStyle ??
                        TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cs.onPrimary,
                        ),
                  ),
                  const Gap(5),
                  Text(
                    'Always active',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<chat_cubit.ChatCubit, chat_cubit.ChatState>(
        listener: (context, state) {
          if (state is chat_cubit.ChatFaliure) {
            ErrorHandler.showErrorSnackBar(context, state.errmessage);
          }
        },
        builder: (context, state) {
          // ✅ بناخد الرسايل من الـ Cubit مباشرة
          final messages = context.read<chat_cubit.ChatCubit>().uiMessages;

          return Chat(
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
           // onAttachmentPressed: _handleAttachmentPressed,
            disableImageGallery: true,
            messages: messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            theme: DefaultChatTheme(
              attachmentButtonIcon:
                  Icon(Icons.image, size: 30, color: cs.onSurfaceVariant),
              primaryColor: cs.primary,
              secondaryColor: cs.surfaceContainerHighest,
              sentMessageBodyTextStyle:
                  TextStyle(color: cs.onPrimary, fontSize: 16),
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
                colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          );
        },
      ),
    );
  }
}