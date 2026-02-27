import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/feature/auth/data/auth_repo.dart';
import 'package:agri_guide_app/feature/auth/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  AuthRepo authRepo = AuthRepo();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Future<void> signup() async {
  //   // Validate passwords match
  //   if (passwordController.text != confirmPasswordController.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Passwords do not match')),
  //     );
  //     return;
  //   }

  //   try {
  //     final user = await authRepo.signup(
  //       firstnameController.text.trim(),
  //       lastnameController.text.trim(),
  //       emailController.text.trim(),
  //       passwordController.text.trim(),
  //       locationController.text.trim(),
  //     );
      
  //     if (user != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Account created successfully')),
  //       );
  //       Navigator.push(context, MaterialPageRoute(builder: (_) => Root()));
  //     }
  //   } catch (e) {
  //     String errormessage = 'Error creating account';
  //     if (e is ApiErrors) {
  //       errormessage = e.message;
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(errormessage)),
  //     );
  //   }
  // }

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              const AuthHeader(),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Center(
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(199, 0, 0, 0),
                              fontFamily: fontFamily,
                            ),
                          ),
                        ),
                        const Gap(25),
                        
                        // First Name
                        CustomeTextFormField(
                          hintText: 'Enter your first name',
                          labelText: 'First Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          controller: firstnameController,
                          isPassword: false,
                        ),
                      const Gap(15),
                        
                        // Last Name
                        CustomeTextFormField(
                          hintText: 'Enter your last name',
                          labelText: 'Last Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          controller: lastnameController,
                          isPassword: false,
                        ),
                        const Gap(15),
                        
                        // Email
                        CustomeTextFormField(
                          hintText: 'Enter your email',
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email),
                          controller: emailController,
                          isPassword: false,
                        ),
                        const Gap(15),
                        
                        // Password
                        CustomeTextFormField(
                          hintText: 'Create a password',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          controller: passwordController,
                          isPassword: _obscurePassword,
                        ),
                        const Gap(15),
                        
                        // Confirm Password
                        CustomeTextFormField(
                          hintText: 'Confirm your password',
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          controller: confirmPasswordController,
                          isPassword: _obscureConfirmPassword,
                        ),
                       const Gap(15),
                        
                        // Location
                        CustomeTextFormField(
                          hintText: 'Your location',
                          labelText: 'Location',
                          prefixIcon: const Icon(Icons.location_on),
                          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_drop_down)),
                          controller: locationController,
                          isPassword: false,
                        ),
                        
                        const Gap(40),
                        
                        // Sign Up Button
                        GestureDetector(
                          onTap: () async {
                            // if (_formkey.currentState?.validate() ?? false) {
                            //   await signup();
                            // }
                          },
                          child: CustomAuthButton(
                            text: 'Sign Up',
                            borderColor: Colors.green,
                            textColor: Colors.white,
                          ),
                        ),
                        
                        const Gap(15),
                        
                        // Go to Login Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
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
                                    builder: (_) => LoginView(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Log in',
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
    );
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    locationController.dispose();
    super.dispose();
  }
}



