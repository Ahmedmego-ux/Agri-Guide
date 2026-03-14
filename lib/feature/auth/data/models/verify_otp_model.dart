import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/verify_otp_entity.dart';

class VerifyOtpModel {
final String email;
final String otpCode;

  VerifyOtpModel({required this.email, required this.otpCode});

factory VerifyOtpModel.fromEntity(VerifyOtpEntity verifyOtpEntity){
  return VerifyOtpModel(email: verifyOtpEntity.email,
   otpCode: verifyOtpEntity.otpCode 
   );

}

}