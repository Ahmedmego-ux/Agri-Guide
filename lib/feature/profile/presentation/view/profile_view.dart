import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
      print('========== profileView ==========');
    return ProfileViewBody();
  }
}
