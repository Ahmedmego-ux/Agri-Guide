import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';

abstract class ProfileRepo {

Future<ProfileEntity> getProfile(String userId);
Future<void> updateData(ProfileEntity entity);

}