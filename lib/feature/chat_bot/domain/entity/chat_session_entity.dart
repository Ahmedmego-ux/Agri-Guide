import 'package:agri_guide_app/feature/chat_bot/domain/entity/message_entity.dart';

class ChatSessionEntity {
  final String id;
  final String title;
  final List<MessageEntity>messages;
  final DateTime createdAt;

  ChatSessionEntity({required this.id, required this.title, required this.messages, required this.createdAt});
}