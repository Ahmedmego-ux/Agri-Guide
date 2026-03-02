
 import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';

abstract class AuthRepo {


  Future<bool> login({LoginEntity logineEntity});
  Future<void> signOut();
  Future<bool> resetPassword({required String email});
  Future<bool> verifyOtp({required String email, required String otp});
  Future<bool> setNewPassword({required String email, required String newPassword});
}


