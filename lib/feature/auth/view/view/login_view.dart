import 'package:agri_guide_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/feature/auth/view/view/reset_password_view.dart';
import 'package:agri_guide_app/feature/auth/view/view/signup_view.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/custom_textformfiled.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
    //logic


  // State
  bool _obscureText = true;
  bool _isLoading = false;

  // Validators
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // Placeholder for login logic
  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement login logic with AuthRepo here

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFFF2),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const AuthHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Center(
                            child: Text(
                              'Login with your Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                          const Gap(50),

                          // Email Field
                          CustomeTextFormField(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email, color: Colors.green),
                            controller: _emailController,
                            validator: _validateEmail,
                             isPassword: false,
                          ),

                          const Gap(30),

                          // Password Field
                          CustomeTextFormField(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock, color: Colors.green),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                            controller: _passwordController,
                            isPassword: _obscureText,
                            validator: _validatePassword,
                          ),

                          const Gap(30),

                          // Location Field
                          CustomeTextFormField(
                            hintText: 'Your location',
                            labelText: 'Location',
                            prefixIcon: const Icon(Icons.location_on),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                            controller: _locationController,
                            isPassword: false,
                          ),

                          const Gap(30),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ResetPasswordView()),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.green, fontSize: 14),
                              ),
                            ),
                          ),

                          const Gap(30),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                                disabledBackgroundColor: Colors.grey[300],
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : const Text(
                                      'Log In',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                            ),
                          ),

                          const Gap(20),

                          // Go to Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const SignupView()),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ),
                            ],
                          ),

                          const Gap(30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}