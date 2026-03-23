import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.loginEntity});
final LoginEntity loginEntity;
  @override
  Widget build(BuildContext context) {
      print('========== profileView ==========');
    print('User ID: ${loginEntity.id}');
    return BlocProvider(
      create: (context) => ProfileCubit(userId:loginEntity.id!)..getProfileData(),
      child: ProfileViewBody(loginEntity: loginEntity,),
    );
  }
}
