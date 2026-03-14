
 import 'package:agri_guide_app/feature/auth/data/models/login_model.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/update_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/verify_otp_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';

abstract class AuthRepo {
  

 Future<void> singup({required SingupEntity singupEntity});
 Future<void> singupWithGoogle();
  Future<void> createProfileFromGoogle({required SingupEntity singupEntity});
  Future<LoginEntity> login({required LoginEntity loginEntity});
  Future<void> resetPassword({required ResetPasswordEntity resetPasswordEntity});
  Future<void> verifyOtp({required VerifyOtpEntity verifyOtpEntity});
  Future<void> updatePassword({required UpdatePasswordEntity updatePasswordEntity});

  // Future<bool> login({LoginEntity logineEntity});
 
  // Future<bool> resetPassword({required String email});
  // Future<bool> verifyOtp({required String email, required String otp});
  // Future<bool> setNewPassword({required String email, required String newPassword});
}


