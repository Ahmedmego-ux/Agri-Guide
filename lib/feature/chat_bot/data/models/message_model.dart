import 'package:agri_guide_app/feature/chat_bot/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity{
  MessageModel({ required super.role,
    super.content,
    super.imageBase64,
    required super.time,
    });


   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
  role: json['role'] ?? 'user',
  content: json['content'],
  imageBase64: json['image_url'],
  time: DateTime.parse(json['created_at']),
);

     Map<dynamic,String >toJson()=>{
       'role': role,
        'text': ?content,
        'imageBase64': ?imageBase64,
        'time': time.toIso8601String(),

     };


}