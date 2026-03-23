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

  // // ✅ دالة لتحديث البيانات (اختياري)
  // Future<void> updateProfile(ProfileEntity profile) async {
  //   emit(ProfileLoading());
    
  //   try {
  //     await profileRepo.updateProfile(profile);
  //     emit(ProfileUpdateSuccess()); // نجاح التحديث
  //     await getProfileData(); // إعادة تحميل البيانات بعد التحديث
  //   } catch (e) {
  //     emit(ProfileError(e.toString()));
  //   }
  // }
}
