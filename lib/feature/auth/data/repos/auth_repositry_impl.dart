

import 'package:agri_guide_app/feature/auth/data/models/login_model.dart';
import 'package:agri_guide_app/feature/auth/data/models/reset_password_model.dart';
import 'package:agri_guide_app/feature/auth/data/models/singup_model.dart';
import 'package:agri_guide_app/feature/auth/data/models/update_password_model.dart';
import 'package:agri_guide_app/feature/auth/data/models/verify_otp_model.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/update_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/verify_otp_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthRepositoryImpl implements AuthRepo {
  final SupabaseClient supabase;

  AuthRepositoryImpl(this.supabase);

  @override
Future<LoginEntity> login({required LoginEntity loginEntity}) async {
  
  try {
    final model = LoginModel.fromEntity(loginEntity);
    
    final response = await supabase.auth.signInWithPassword(
      email: model.email,
      password: model.password,
    );

    
    if (response.user == null) {
      throw Exception('Login failed: User not found');
    }
 
 
    final profileData = await supabase
        .from('profiles')
        .select('id, email, first_name, last_name, city_name')
        .eq('id', response.user!.id)
        .maybeSingle();

            

     if (profileData != null) {
        print('Profile data from Supabase: $profileData');
        return LoginEntity(
          id: profileData['id'],
          email: profileData['email'],
          password: '',
          firstName: profileData['first_name'] ?? '',
          lastName: profileData['last_name'] ?? '',
          cityName: profileData['city_name'] ?? '', 
        );
      }

      // لو مفيش بيانات بروفايل (مستخدم جديد)
      return LoginEntity(
        id: response.user!.id,
        email: response.user!.email ?? '',
        password: '',
        firstName: '',
        lastName: '',
        cityName: '',
      );


  } on AuthException catch (e) {
    throw Exception('Login failed: ${e.message}');
  } catch (e) {
    throw Exception('Login failed: $e');
  }
}





 @override
  Future<void> singup({required SingupEntity singupEntity}) async {
    final model = SignUpModel.fromSingUpEntity(singupEntity);
      final email = singupEntity.email.trim();
  final password = singupEntity.password; 
     if (!email.endsWith('@gmail.com')) {
    throw Exception('You can only sign up with a Gmail account');
  }
print("EMAIL RAW: ${model.email}");
print("EMAIL LENGTH: ${model.email.length}");
    final response = await supabase.auth.signUp(
      email: model.email,
      password: model.password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception("User creation failed");
    }

    await supabase.from('profiles').insert(model.toJson(user.id));
  }





  
  @override
  Future<void> singupWithGoogle()async {
  await supabase.auth.signInWithOAuth(
    OAuthProvider.google
   );
  }
  
  @override
  Future<void> createProfileFromGoogle({required SingupEntity singupEntity})async {
   
    
   final user=supabase.auth.currentUser;
   if(user==null)return;
//    {
// throw Exception("User creation failed");
//    }


  await supabase.from('profiles').upsert({
    "id": user.id,
    "email": user.email,
    "name": user.userMetadata?['full_name'],
    "city_name": singupEntity.cityName,
    
  });

}

  @override
  Future<void> resetPassword({required ResetPasswordEntity resetPasswordEntity})async {
  
    try {
final model= ResetPasswordModel.fromEntity(entity: resetPasswordEntity);
  await supabase.auth.signInWithOtp(
    shouldCreateUser: false,
   email:  model.email
  );
}  catch (e) {
  throw Exception('Reset failed : $e');
}




  }

  @override
  Future<void> updatePassword({required UpdatePasswordEntity updatePasswordEntity})async {
     try {
final model=  UpdatePasswordModel.fromEntity( updatePasswordEntity);
  await supabase.auth.updateUser(
   UserAttributes(password: model.newPassword),
  );
}  catch (e) {
  throw Exception('Update password failed: $e');
}
  }

  @override
  Future<void> verifyOtp({required VerifyOtpEntity verifyOtpEntity}) async{

    try {
    final model = VerifyOtpModel.fromEntity(verifyOtpEntity);
    await supabase.auth.verifyOTP(
      email: model.email,
      token: model.otpCode,
      type: OtpType.email,
    );
  } catch (e) {
    throw Exception('Verify OTP failed: $e');
  }}

  }
 
  
 


