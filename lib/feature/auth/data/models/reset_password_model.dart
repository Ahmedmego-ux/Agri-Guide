import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';

class ResetPasswordModel {
final String email;


  ResetPasswordModel({required this.email});

  factory ResetPasswordModel.fromEntity({required ResetPasswordEntity entity}){
    return ResetPasswordModel(email: entity.email);
  }

    /// ✅ لتحويل Model لـ JSON (للبعث لـ Supabase Auth)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      
    };
  }
   

}