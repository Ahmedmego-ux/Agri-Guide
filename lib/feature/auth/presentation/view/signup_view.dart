import 'package:agri_guide_app/feature/auth/presentation/manger/singup/sing_up_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/sing_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingUpCubit(),
      child: const SignupViewBody(),
    );
  }
}
