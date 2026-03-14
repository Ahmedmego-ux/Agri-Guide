import 'package:agri_guide_app/feature/auth/view/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: OtpViewBody(email: email),
    );
  }
}
