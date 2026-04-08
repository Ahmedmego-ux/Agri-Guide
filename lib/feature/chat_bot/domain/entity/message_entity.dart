class MessageEntity {
  final String role;
  final String? content;
  final String? imageBase64;
  final DateTime time;

  MessageEntity({required this.role,  this.content,  this.imageBase64, required this.time});
   bool get isImage => imageBase64 != null;
  bool get isText => content != null;
}