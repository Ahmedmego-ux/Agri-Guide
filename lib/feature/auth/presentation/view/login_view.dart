
import 'package:agri_guide_app/feature/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/login/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, this.email, this.password });
 final String? email;
  final String ?password;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child:  LoginViewBody(email: email, password: password,),
    );
  }
}