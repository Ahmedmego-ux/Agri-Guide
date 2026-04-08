import 'package:agri_guide_app/feature/chat_bot/data/chat_repo_impl.dart/chat_repo_impl.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/repos/chat_repo.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/session/session_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/message/chat_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/widget/chat_bot_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatBotViewBody();
  }
}
