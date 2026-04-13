import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/domain/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.repo) : super(SessionInitial());
  final ChatRepo repo;

  Future<void> getSessions() async {
    emit(SessionLoading());
    final result = await repo.getSessions();
    result.fold(
      (error) => emit(SessionFailure(errmessage: error)),
      (sessions) => emit(SessionSuccess(sessions: sessions)),
    );
  }

  Future<void> createSession(String title) async {
    emit(SessionLoading());
    final result = await repo.createSession(title);
    result.fold(
      (error) {
        emit(SessionFailure(errmessage: error));
        return null;
      },
      (session) {
        getSessions(); 
        emit(SessionCreatedSuccess(session: session));
        return null;
      },
    );
  }

  // ✅ إضافة دالة تحديث عنوان الجلسة
  Future<void> updateSessionTitle(String sessionId, String title) async {
    final result = await repo.updateSessionTitle(sessionId, title);
    result.fold(
      (error) {
        // يمكن إضافة emit للحالة إذا أردت
        print('Error updating session title: $error');
      },
      (_) {
        // تحديث قائمة الجلسات بعد التحديث
        getSessions();
      },
    );
  }
}