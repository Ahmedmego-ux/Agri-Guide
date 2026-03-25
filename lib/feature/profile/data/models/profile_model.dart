import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';

class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String location;

  ProfileModel({required this.id, 
  required this.firstName, 
  required this.lastName,
   required this.email,
    required this.location});


    factory ProfileModel.fromEntity(ProfileEntity entity){
      return ProfileModel(id: entity.id,
       firstName: entity.firstName, 
       lastName: entity.lastName,
        email: entity.email,
         location: entity.location);
    }

    factory ProfileModel.fromJson(Map<String,dynamic>json){
      return ProfileModel(
         id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      location: json['city_name'] as String,
       );
    }

   Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id':id,
      'first_name':firstName,
      'last_name':lastName,
      'city_name':location

    };
  }

}