
 import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';

abstract class AuthRepo {
  

 Future<void> Singup({required SingupEntity singupEntity});
  // Future<bool> login({LoginEntity logineEntity});
 
  // Future<bool> resetPassword({required String email});
  // Future<bool> verifyOtp({required String email, required String otp});
  // Future<bool> setNewPassword({required String email, required String newPassword});
}


