part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordLoading extends ResetPasswordState {}
final class ResetPasswordSuccess extends ResetPasswordState {}
final class ResetPasswordFailure extends ResetPasswordState {
  final String errmessage;

  ResetPasswordFailure({required this.errmessage});
}
//otp verif 
class VerifyOtpSuccess extends ResetPasswordState {}
class VerifyOtpFailure extends ResetPasswordState {
  final String errmessage;
  VerifyOtpFailure({required this.errmessage});
}

// update password
class UpdatePasswordSuccess extends ResetPasswordState {}
class UpdatePasswordFailure extends ResetPasswordState {
  final String errmessage;
  UpdatePasswordFailure({required this.errmessage});
}
