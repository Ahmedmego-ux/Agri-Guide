import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/login/login_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/reset_password_view.dart';

import 'package:agri_guide_app/feature/auth/presentation/view/signup_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_validator.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';

import 'package:agri_guide_app/feature/home/presentation/view/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:agri_guide_app/core/constans/app_strings.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // State
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  

  // Login logic
  void _login() {
    if (!_formKey.currentState!.validate()) return;

    final  entity = LoginEntity(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    context.read<LoginCubit>().login(userData:entity, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errmessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginSuccess) {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
        //  ErrorHandler.showSuccessSnackBar(context,
        //   'Welcome back,${state.userData.firstName ?? state.userData.email} !')
        //  ;
        } 
      },
      builder: (context, state) {
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
                                validator: AuthValidators.validateEmail,
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
                                validator: AuthValidators.validatePassword,
                              ),

                              const Gap(10),

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
                                  onPressed: (state is LoginLoading) ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                    disabledBackgroundColor: Colors.grey[300],
                                  ),
                                  child: (state is LoginLoading)
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
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
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
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
      },
    );
  }
}