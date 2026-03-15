import 'package:agri_guide_app/feature/auth/presentation/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/new_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: NewPasswordViewBody(email: email),
    );
  }
}
