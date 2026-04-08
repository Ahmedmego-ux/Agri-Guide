import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';

class LoginModel {
  // بيانات تسجيل الدخول الأساسية
  final String email;
  final String password;

  // بيانات البروفايل
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? cityName;
  final double ?latitude;
 final double ?longitude;

  
 
 

  

  /// ✅ من Entity لـ Model (للبعث لـ API)
  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      email: entity.email,
      password: entity.password,
      firstName: entity.firstName,
      lastName: entity.lastName,
      cityName: entity.cityName, 
      id: entity.id,
       latitude: entity.latitude,
        longitude: entity.longitude
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
   factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      password: '',
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      cityName: json['city_name'] as String?,
       latitude:json['latitude'] as double?, 
        longitude: json['longitude'] as double?,
     
    );
  }

  LoginModel({required this.email, 
  required this.password, 
  required this.id, 
  required this.firstName, 
  required this.lastName,
   required this.cityName,
    required this.latitude,
    required this.longitude});


}