import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/update_password_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'auth_header.dart';
import 'new_password_header.dart';
import 'new_password_requirements.dart';
import 'new_password_strength.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key, required this.email});
  final String email;

  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ===== Password Strength =====
  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasLowercase => _passwordController.text.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial => _passwordController.text.contains(RegExp(r'[!@#$%^&*]'));

  double get _passwordStrength {
    if (_passwordController.text.isEmpty) return 0;
    double strength = 0;
    if (_hasMinLength) strength += 0.2;
    if (_hasUppercase) strength += 0.2;
    if (_hasLowercase) strength += 0.2;
    if (_hasNumber) strength += 0.2;
    if (_hasSpecial) strength += 0.2;
    return strength;
  }

  String get _strengthText {
    if (_passwordStrength <= 0.2) return 'Weak';
    if (_passwordStrength <= 0.4) return 'Fair';
    if (_passwordStrength <= 0.6) return 'Medium';
    if (_passwordStrength <= 0.8) return 'Strong';
    return 'Very Strong';
  }

  Color get _strengthColor {
    if (_passwordStrength <= 0.2) return Colors.red;
    if (_passwordStrength <= 0.4) return Colors.orange;
    if (_passwordStrength <= 0.6) return Colors.yellow;
    if (_passwordStrength <= 0.8) return Colors.lightGreen;
    return Colors.green;
  }

  // ===== Helpers =====
  void _showSnack(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }

  void _onSubmit() {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnack('Please fill all fields', Colors.red);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnack('Passwords do not match', Colors.red);
      return;
    }
    context.read<ResetPasswordCubit>().updatePassword(
          entity: UpdatePasswordEntity(newPassword: _passwordController.text),
        );
  }

  void _listener(BuildContext context, ResetPasswordState state) {
    if (state is UpdatePasswordSuccess) {
      _showSnack('Password updated successfully!', Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
    }
    if (state is UpdatePasswordFailure) {
      _showSnack(state.errmessage, Colors.red);
    }
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: _listener,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    const AuthHeader(),
                    const Gap(40),
                    const NewPasswordHeader(),
                    const Gap(40),
                    _buildPasswordField(),
                    const Gap(16),
                    NewPasswordStrength(
                      passwordStrength: _passwordStrength,
                      strengthText: _strengthText,
                      strengthColor: _strengthColor,
                    ),
                    const Gap(24),
                    _buildConfirmField(),
                    const Gap(32),
                    CustomAuthButton(
                      text: 'Reset Password',
                      isLoading: state is ResetPasswordLoading,
                      onPressed: state is ResetPasswordLoading ? null : _onSubmit,
                    ),
                    const Gap(24),
                    NewPasswordRequirements(
                      hasMinLength: _hasMinLength,
                      hasUppercase: _hasUppercase,
                      hasLowercase: _hasLowercase,
                      hasNumber: _hasNumber,
                      hasSpecial: _hasSpecial,
                    ),
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

  Widget _buildPasswordField() {
    return CustomeTextFormField(
      hintText: 'Enter new password',
      labelText: 'New Password',
      prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
      suffixIcon: IconButton(
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
      controller: _passwordController,
      isPassword: _obscurePassword,
    );
  }

  Widget _buildConfirmField() {
    return CustomeTextFormField(
      hintText: 'Confirm new password',
      labelText: 'Confirm Password',
      prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
      suffixIcon: IconButton(
        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
        icon: Icon(
          _obscureConfirm ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
      controller: _confirmPasswordController,
      isPassword: _obscureConfirm,
    );
  }
}