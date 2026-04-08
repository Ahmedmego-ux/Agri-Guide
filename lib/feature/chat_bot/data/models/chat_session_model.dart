import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';

class ChatSessionModel extends ChatSessionEntity{
  ChatSessionModel({required super.id,
   required super.title,
    required super.messages,
     required super.createdAt});

     factory ChatSessionModel.fromJson(Map<String,dynamic>json){
      return ChatSessionModel(
         id: json['id'],
        title: json['title'],
        messages: [],
        createdAt: DateTime.parse(json['created_at']),
        );
     }

     Map<String, dynamic> toJson() => {
  'title': title,
  'created_at': createdAt.toIso8601String(),
};
}