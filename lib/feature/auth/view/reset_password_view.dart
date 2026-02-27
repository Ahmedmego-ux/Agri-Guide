// lib/feature/auth/view/reset_password_view.dart
import 'package:agri_guide_app/feature/auth/view/otp_view.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/auth_header.dart';


class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFFF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                
                // Auth Header (اللي إنت عاملها)
                const AuthHeader(),
                
                const Gap(40),
                
                // Title
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const Gap(12),
                
                // Description
                Text(
                  'Enter your email address and we\'ll send you a verification code to reset your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                
                const Gap(40),
                
                // Email Field (باستخدام CustomTextFormField)
                CustomeTextFormField(
                  hintText: 'farmer@example.com',
                  labelText: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.green),
                  controller: TextEditingController(), // هنربطها بالـ Logic بعدين
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                
                const Gap(32),
                
                // Send Button (باستخدام CustomAuthButton)
                CustomAuthButton(
                  text: 'Send Verification Code',
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>OtpView()));
                  }, // هنضيف logic بعدين
                ),
                
                const Gap(20),
                
                // Back to Login Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const Gap(40),
                
                // Security Tips Section
                _buildSecurityTips(),
                
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityTips() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.green[700],
                size: 22,
              ),
              const Gap(8),
              Text(
                'Security Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const Gap(16),
          _buildSecurityTip(
            icon: Icons.lock_outline,
            text: 'Use a unique password you don\'t use elsewhere',
          ),
          const Gap(12),
          _buildSecurityTip(
            icon: Icons.password,
            text: 'Include letters, numbers, and symbols',
          ),
          const Gap(12),
          _buildSecurityTip(
            icon: Icons.share,
            text: 'Never share your password with anyone',
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTip({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.green[600],
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}