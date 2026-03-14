import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/auth/data/repos/auth_repositry_impl.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/update_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/verify_otp_entity.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
 
 final authRepo=AuthRepositoryImpl(Supabase.instance.client);
  Future<void> resetPassword ({required ResetPasswordEntity entity})async {


    emit(ResetPasswordLoading());
try {
 await authRepo.resetPassword(resetPasswordEntity: entity);
  emit(ResetPasswordSuccess());
}  catch (e) {
  print('🔴 Error: $e');
  emit(ResetPasswordFailure(errmessage:ErrorHandler.handleAuthError(e)));
}

  }

  Future<void> verifyOtp({required VerifyOtpEntity entity})async{
emit(ResetPasswordLoading());
try {
 await authRepo.verifyOtp(verifyOtpEntity: entity);
  emit(VerifyOtpSuccess());
} catch (e) {
  print('🔴 Error: $e');
  emit(VerifyOtpFailure(errmessage:ErrorHandler.handleAuthError(e)));
}

  }


Future<void> updatePassword({required UpdatePasswordEntity entity})async{
emit(ResetPasswordLoading());
  try {
await  authRepo.updatePassword(updatePasswordEntity: entity);
  emit(UpdatePasswordSuccess());
}  catch (e) {
  print('🔴 Error: $e');
  emit(UpdatePasswordFailure(errmessage:ErrorHandler.handleAuthError(e)));
  
}
  
}

}
