import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:agri_guide_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RepoImpl extends ProfileRepo {
final supabase=Supabase.instance.client;

  @override
  Future<ProfileEntity> getProfile(String userId) async{
     try {
  final response = await supabase
       .from('profiles')
       .select()
       .eq('id', userId)
       .single();
        return ProfileEntity(
     id: response['id'],
     firstName: response['first_name'],
     lastName: response['last_name'],
     email: response['email'],
     location: response['city_name'], 
   );
}catch (e) {
      throw Exception('Failed to Load profile: $e');
    }



  }

}