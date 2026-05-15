import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';

import 'package:agri_guide_app/feature/home/presentation/widgets/home_view_body.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.loginEntity});
  final LoginEntity loginEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(userId: loginEntity.id)..getProfileData(),
      child: HomeViewBody(loginEntity: loginEntity),
    );
  }
}
