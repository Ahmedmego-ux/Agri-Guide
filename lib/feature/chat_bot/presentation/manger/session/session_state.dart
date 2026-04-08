// في ملف session_state.dart
part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionSuccess extends SessionState {
  final List<ChatSessionEntity> sessions;
  const SessionSuccess({required this.sessions});
  @override
  List<Object> get props => [sessions];
}

class SessionFailure extends SessionState {
  final String errmessage;
  const SessionFailure({required this.errmessage});
  @override
  List<Object> get props => [errmessage];
}

class SessionCreatedSuccess extends SessionState {
  final ChatSessionEntity session;
  const SessionCreatedSuccess({required this.session});
  @override
  List<Object> get props => [session];
}