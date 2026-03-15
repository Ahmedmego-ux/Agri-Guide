import 'dart:convert';

import 'package:agri_guide_app/core/service/location_handler.dart';
import 'package:agri_guide_app/core/service/location_service.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/singup/sing_up_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_validator.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/google_button.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/or_divider.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/sing_up_botton.dart';
import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/location_field.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _locationController = TextEditingController();

  double? _latitude;
  double? _longitude;

  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
   late LocationHandler _locationHandler;

  @override
  void initState() {
    super.initState();
    _locationHandler = LocationHandler(
      showSnack: _showSnack,
      onLocationObtained: (lat, lng, cityName) {  // ✅ 3 parameters now
      setState(() {
        _latitude = lat;
        _longitude = lng;
        _locationController.text = cityName;  // ✅ هتظهر "Cairo, Egypt"
      });
    },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// BUILD ENTITY
  SingupEntity _buildEntity() {
    return SingupEntity(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      cityName: _locationController.text.trim()
    );
  }

  /// GET LOCATION
  /// GET LOCATION (يجيب اسم المدينة)


  void _showSnack(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }

 Future <void> _signup()async {

    if (!_formKey.currentState!.validate()) return;

  await  context.read<SingUpCubit>().signup(
          _buildEntity(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SingUpCubit, SingUpState>(
      listener: (context, state) {

        if (state is SingUpFailure) {
          _showSnack(state.errmessage, Colors.red);
        }

        if (state is SingUpSuccess) {

          _showSnack('Account created successfully', Colors.green);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Root()),
          );
        }
      },

      builder: (context, state) {

    

        return GestureDetector(

          onTap: () => FocusScope.of(context).unfocus(),

          child: Stack(
            children:[ Scaffold(
              backgroundColor: const Color(0xffFFFFFFF2),
            
              body: Form(
                key: _formKey,
            
                child: Column(
                  children: [
            
                    const SizedBox(height: 60),
                    const AuthHeader(),
            
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
            
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
            
                              const Gap(20),
            
                              CustomeTextFormField(
                                hintText: 'Enter your first name',
                                labelText: 'First Name',
                                controller: _firstNameController,
                                prefixIcon: const Icon(Icons.person_outline),
                                validator: (v) => AuthValidators
                                    .validateNotEmpty(v, "First Name"),
                                isPassword: false,
                              ),
            
                              const Gap(15),
            
                              CustomeTextFormField(
                                hintText: 'Enter your last name',
                                labelText: 'Last Name',
                                controller: _lastNameController,
                                prefixIcon: const Icon(Icons.person_outline),
                                validator: (v) => AuthValidators
                                    .validateNotEmpty(v, "Last Name"),
                                isPassword: false,
                              ),
            
                              const Gap(15),
            
                              CustomeTextFormField(
                                hintText: 'Enter your email',
                                labelText: 'Email',
                                controller: _emailController,
                                prefixIcon: const Icon(Icons.email),
                                validator: AuthValidators.validateEmail,
                                isPassword: false,
                              ),
            
                              const Gap(15),
            
                              CustomeTextFormField(
                                hintText: 'Create password',
                                labelText: 'Password',
                                controller: _passwordController,
                                prefixIcon: const Icon(Icons.lock),
                                validator: AuthValidators.validatePassword,
                                isPassword: _obscurePassword,
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
                              ),
            
                              const Gap(15),
            
                              CustomeTextFormField(
                                hintText: 'Confirm password',
                                labelText: 'Confirm Password',
                                controller: _confirmPasswordController,
                                prefixIcon: const Icon(Icons.lock),
                                isPassword: _obscureConfirmPassword,
                                validator: (v) {
            
                                  if (v != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
            
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
            
                              const Gap(15),
            
                              /// LOCATION FIELD
                              LocationField(
                                controller: _locationController,
                                isLoading: _locationHandler.isLoading,
                                onTap:_locationHandler.getLocation ,
                              ),
            
                              const Gap(40),
                              
            
                              /// SIGNUP BUTTON
                              SignupButton(
                                
                                onTap: _signup,
                              ),
            
                              const Gap(20),
            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
            
                                  Text(
                                    'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
            
                                  GestureDetector(
                                    onTap: () {
            
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginView(),
                                        ),
                                      );
            
                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
            
                            //  OrDivider(),
                            //  GoogleButton(onTap: () =>context.read<SingUpCubit>().SingupWithGoogle(context, singupEntity: _buildEntity()),),
                             Gap(30)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
            ),
             if (state is SingUpLoading)
          Container(
            color: Colors.black.withOpacity(0.3), 
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),)
            ]
          ),
        );
      },
    );
  }
}