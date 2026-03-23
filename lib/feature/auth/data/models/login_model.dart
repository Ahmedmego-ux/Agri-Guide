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

  
 
 

  LoginModel({
    // أساسي
    required this.email,
    required this.password,
    
    // بروفايل
    this.id,
    this.firstName,
    this.lastName,
    this.cityName,
    
    
    
  });

  /// ✅ من Entity لـ Model (للبعث لـ API)
  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      email: entity.email,
      password: entity.password,
      firstName: entity.firstName,
      lastName: entity.lastName,
      cityName: entity.cityName
    );
  }

  /// ✅ لتحويل Model لـ JSON (للبعث لـ Supabase Auth)
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
     
    );
  }

  /// ✅ لتحويل بيانات المستخدم بعد login (لتخزينها في جدول users/profiles)
  // static Map<String, dynamic> userToJson({
  //   required String userId,
  //   required String email,
  //   String? firstName,
  //   String? lastName,
  //   String? cityName,
   
  // }) {
  //   return {
  //     'id': userId,
  //     'email': email,
  //     if (firstName != null) 'first_name': firstName,
  //     if (lastName != null) 'last_name': lastName,
  //     if (cityName != null) 'city_name': cityName,
     
  //     'updated_at': DateTime.now().toIso8601String(),
  //   };
  // }

  /// ✅ من JSON (الراجع من Supabase) لـ Model
 

  

  // String get initials {
  //   if (firstName != null && lastName != null) {
  //     return '${firstName![0]}${lastName![0]}'.toUpperCase();
  //   } else if (firstName != null) {
  //     return firstName![0].toUpperCase();
  //   } else if (lastName != null) {
  //     return lastName![0].toUpperCase();
  //   } else {
  //     return email[0].toUpperCase();
  //   }
  // }


  /// ✅ لتحويل Model لـ Entity (عشان تستخدمه في الـ UI)
  // LoginEntity toEntity() {
  //   return LoginEntity(
  //     email: email,
  //     password: password,
  //   );
  // }

  // /// ✅ لعمل كوبي من المودل مع تغيير بعض القيم
  // LoginModel copyWith({
  //   String? firstName,
  //   String? lastName,
  //   String? cityName,
   
  // }) {
  //   return LoginModel(
  //     id: id,
  //     email: email,
  //     password: password,
  //     firstName: firstName ?? this.firstName,
  //     lastName: lastName ?? this.lastName,
  //     cityName: cityName ?? this.cityName,
     
  //   );
  // }
}