import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/entity/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<String, String>> sendMessage(
    List<MessageEntity> messages,
  );
Future <void>saveMessage( String sessionId, MessageEntity message);
Future<Either<String, List<ChatSessionEntity>>> getSessions();

Future<Either<String,List<MessageEntity>>> getMessages(String sessionId);

 Future<Either<String, ChatSessionEntity>> createSession(String title);

   Future<Either<String, void>> updateSessionTitle(String sessionId, String title);

}