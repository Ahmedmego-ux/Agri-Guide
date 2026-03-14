import 'package:agri_guide_app/feature/auth/view/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final VoidCallback onTap;

  const SignupButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CustomAuthButton(
        backgroundColor: Colors.green,
        text: 'Sign Up',
        borderColor: Colors.green,
        textColor: Colors.white,
      ),
    );
  }
}