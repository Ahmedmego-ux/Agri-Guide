part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String reply;
  const ChatSuccess(this.reply);
  @override
  List<Object?> get props => [reply];
}

class ChatFaliure extends ChatState {
  final String errmessage;
  const ChatFaliure(this.errmessage);
  @override
  List<Object> get props => [errmessage];
}