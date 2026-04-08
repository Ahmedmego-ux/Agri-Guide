import 'package:agri_guide_app/feature/profile/data/repositry/repo_impl.dart';
import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  
  final RepoImpl profileRepo;
  final String userId; 


  ProfileCubit({required this.userId}) 
    : profileRepo = RepoImpl(),
      super(ProfileInitial());

  
  Future<void> getProfileData() async {
    emit(ProfileLoading()); 
    
    try {
      print("fffffffffffffffffffffff$userId");
      final profile = await profileRepo.getProfile(userId); 
      emit(ProfileSuccess(profileEntity: profile)); 
    } catch (e) {
      emit(ProfileFaliure(errmessage: e.toString())); 
    }
  }


Future<void>updateData({required ProfileEntity profile})async{
emit(ProfileLoading());
try {
  await profileRepo.updateData(profile);
  emit(ProfileSuccessUpdate());
  await getProfileData(); 
}  catch (e) {
emit(ProfileFaliure(errmessage: e.toString()));
}


}
Future<void>deletData( {required String userId})async{
emit(ProfileLoading());
try {
  await profileRepo.deletData(userId);
  emit(DeleteSuccess());
}  catch (e) {
 emit(ProfileFaliure(errmessage: e.toString()));
}
}

  
}
