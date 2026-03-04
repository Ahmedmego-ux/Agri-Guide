import 'package:agri_guide_app/feature/auth/data/repos/auth_repositry_impl.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/feature/auth/view/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/view/widgets/custome_auth_buttom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Validators
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName cannot be empty';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // Placeholder for signup logic
  Future<void> _signup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // TODO: Implement signup logic with AuthRepo here
    final AuthRepo authRepo=AuthRepositoryImpl(Supabase.instance.client);
    final entity = SingupEntity(
  firstName: _firstNameController.text.trim(),
  lastName: _lastNameController.text.trim(),
  email: _emailController.text.trim(),
  password: _passwordController.text.trim(),
  latitude: 0.0, // لو عايز تجيب من GPS بعدين
  longitude: 0.0,
);
try {
  await authRepo.Singup(singupEntity: entity);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Account created successfully')),
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Root()));
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error creating account: $e')),
  );
}
    
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
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
                          controller: _firstNameController,
                          validator: (v) => _validateNotEmpty(v, 'First Name'), isPassword: false
                        ),
                        const Gap(15),

                        // Last Name
                        CustomeTextFormField(
                          hintText: 'Enter your last name',
                          labelText: 'Last Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          controller: _lastNameController,
                          validator: (v) => _validateNotEmpty(v, 'Last Name'), isPassword: false,
                        ),
                        const Gap(15),

                        // Email
                        CustomeTextFormField(
                          hintText: 'Enter your email',
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email),
                          controller: _emailController,
                          validator: _validateEmail, isPassword: false,
                        ),
                        const Gap(15),

                        // Password
                        CustomeTextFormField(
                          hintText: 'Create a password',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          controller: _passwordController,
                          isPassword: _obscurePassword,
                          validator: _validatePassword,
                        ),
                        const Gap(15),

                        // Confirm Password
                        CustomeTextFormField(
                          hintText: 'Confirm your password',
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          controller: _confirmPasswordController,
                          isPassword: _obscureConfirmPassword,
                          validator: _validatePassword,
                        ),
                        const Gap(15),

                        // Location
                        CustomeTextFormField(
                          hintText: 'Your location',
                          labelText: 'Location',
                          prefixIcon: const Icon(Icons.location_on),
                          suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
                          controller: _locationController,
                          validator: (v) => _validateNotEmpty(v, 'Location'), isPassword: false
                        ),
                        const Gap(40),

                        // Sign Up Button
                        GestureDetector(
                          onTap: _signup,
                          child: const CustomAuthButton(
                            backgroundColor: Colors.green,
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
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginView()),
                                );
                              },
                              child: const Text(
                                'Log in',
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
    );
  }
}