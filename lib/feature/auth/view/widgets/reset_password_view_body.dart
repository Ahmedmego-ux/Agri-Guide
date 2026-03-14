import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/view/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/view/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/view/view/otp_view.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/auth_header.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  ResetPasswordEntity _buildEntity() {
    return ResetPasswordEntity(email: _emailController.text.trim());
  }

  void _showSnack(String text, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFFF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginView())),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OtpView(email: _emailController.text.trim()),
                    ),
                  );
                }
                if (state is ResetPasswordFailure) {
                  _showSnack(state.errmessage, Colors.red);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    const AuthHeader(),
                    const Gap(40),
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Enter your email address and we\'ll send you a verification code to reset your password.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const Gap(40),
                    CustomeTextFormField(
                      hintText: 'farmer@example.com',
                      labelText: 'Email Address',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.green,
                      ),
                      controller: _emailController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(32),
                    CustomAuthButton(
                      text: 'Send Verification Code',
                      isLoading: state is ResetPasswordLoading,
                      onPressed: state is ResetPasswordLoading
                          ? null
                          : () {
                              if (_emailController.text.trim().isEmpty) {
                                _showSnack(
                                  "Please enter your email",
                                  Colors.red,
                                );
                                return;
                              }

                              context.read<ResetPasswordCubit>().resetPassword(
                                entity: _buildEntity(),
                              );
                            },
                    ),
                    const Gap(20),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
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
                    _buildSecurityTips(),
                    const Gap(30),
                  ],
                );
              },
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
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: Colors.green[700], size: 22),
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
        Icon(icon, size: 18, color: Colors.green[600]),
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
