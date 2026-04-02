

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/profile/data/models/profile_model.dart';
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
  
  @override
  Future<void> updateData(ProfileEntity entity) async {
    try {
  final model=ProfileModel.fromEntity(entity);
     await supabase.from('profiles')
   .update(model.toJson())
   .eq('id', model.id);
}  catch (e) {
  ErrorHandler.handlePostgrestError(e.toString());
}
  }
  
  @override
  Future<void> deletData(String userId)async {
    try {
   await supabase
        .from('profiles')
        .delete()
        .eq('id', userId);

    // تاني سجل خروج
    await supabase.auth.signOut();
}  catch (e) {
   ErrorHandler.handlePostgrestError(e.toString());
}
  }

}