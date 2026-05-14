import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/otp_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'auth_header.dart';
import 'package:easy_localization/easy_localization.dart';

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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.primary),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
          ),
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
                  _showSnack(state.errmessage, theme.colorScheme.error);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    const AuthHeader(),
                    const Gap(40),

                    Text(
                      'resetPassword'.tr(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(12),

                    Text(
                      'resetPasswordDescription'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),

                    const Gap(40),

                    CustomeTextFormField(
                      hintText: 'farmer@example.com',
                      labelText: 'emailAddress'.tr(),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: theme.iconTheme.color,
                      ),
                      controller: _emailController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const Gap(32),

                    CustomAuthButton(
                      text: 'sendVerificationCode'.tr(),
                      isLoading: state is ResetPasswordLoading,
                      onPressed: state is ResetPasswordLoading
                          ? null
                          : () {
                              if (_emailController.text.trim().isEmpty) {
                                _showSnack(
                                  'pleaseEnterYourEmail'.tr(),
                                  theme.colorScheme.error,
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
                          'backToLogin'.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),

                    const Gap(40),

                    _buildSecurityTips(theme),

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

  Widget _buildSecurityTips(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
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
                color: theme.colorScheme.primary,
                size: 22,
              ),
              const Gap(8),
              Text(
                'securityTips'.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const Gap(16),

          _buildSecurityTip(
            icon: Icons.lock_outline,
            text: 'securityTip1'.tr(),
            theme: theme,
          ),

          const Gap(12),

          _buildSecurityTip(
            icon: Icons.password,
            text: 'securityTip2'.tr(),
            theme: theme,
          ),

          const Gap(12),

          _buildSecurityTip(
            icon: Icons.share,
            text: 'securityTip3'.tr(),
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTip({
    required IconData icon,
    required String text,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}