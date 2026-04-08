import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';

class SignUpModel {
  final String firstName;
  final String lastName;
  final String password;
  final String email;
 final String cityName;
 final double latitude;
 final double longitude;

  SignUpModel({required this.firstName,
   required this.lastName,
    required this.password,
     required this.email,
      required this.cityName,
       required this.latitude, 
       required this.longitude});
  


  Map<String, dynamic> toJson(String userId) {
    return {
      'id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'city_name':cityName,
      'latitude':latitude,
      'longitude':longitude
      
    };
  }
  factory SignUpModel.fromSingUpEntity(SingupEntity entity){
    return SignUpModel(
      firstName: entity.firstName,
       lastName: entity.lastName,
        password:entity.password,
         email: entity.email, cityName: entity.cityName,
          latitude: entity.latitude, 
          longitude:entity.longitude ,
          );

  }

  
}
