import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/feature/auth/data/auth_repo.dart';
import 'package:agri_guide_app/feature/auth/view/signup_view.dart';
import 'package:agri_guide_app/feature/auth/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';

import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AuthRepo authRepo = AuthRepo();
  bool _obscureText = true;
  bool _isLoading = false;

  // Validators
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    
    if (_formkey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await authRepo.login(
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
        );
        
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement( // استخدام pushReplacement عشان مايرجعش للخلف
            context, 
            MaterialPageRoute(builder: (_) => Root())
          );
        }
      } catch (e) {
        String errormessage = 'Error logging in';
        if (e is ApiErrors) {
          errormessage = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errormessage),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formkey,
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
                          Custome_Textformfield(
                            hintText: 'Enter your email',
                            lableText: 'Email',
                            prefixicon: const Icon(Icons.email, color: Colors.green),
                            controller: emailcontroller,
                            ispassword: false,
                           
                          ),
                          
                          const Gap(30),
                          
                          // Password Field
                          Custome_Textformfield(
                            hintText: 'Enter your password',
                            lableText: 'Password',
                            prefixicon: const Icon(Icons.lock, color: Colors.green),
                            suffixicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                            controller: passwordcontroller,
                            ispassword: _obscureText,
                          
                          ),
                          const Gap(30),


                           Custome_Textformfield(
                          hintText: 'Your location',
                          lableText: 'Location',
                          prefixicon: const Icon(Icons.location_on),
                          suffixicon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_drop_down)),
                          controller: locationController,
                          ispassword: false,
                        ),
                          
                          const Gap(30),
                          
                          // Forgot Password (optional)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // هتضيف هنا منطق نسيت كلمة المرور
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          
                        // const Gap(40),
                          
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: Colors.grey[300],
                              ),
                              child: _isLoading
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
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignupView(),
                                    ),
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
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}


