import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/update_password_entity.dart';

class UpdatePasswordModel {
  final String newPassword;

  UpdatePasswordModel({required this.newPassword});

  factory UpdatePasswordModel.fromEntity(UpdatePasswordEntity entity){
    return UpdatePasswordModel(newPassword: entity.newPassword);
  }
}