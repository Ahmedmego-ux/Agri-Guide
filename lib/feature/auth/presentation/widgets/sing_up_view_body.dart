import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'custome_auth_buttom.dart';
import 'custom_textformfiled.dart';
import 'auth_header.dart';
import 'location_field.dart';
import 'auth_validator.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/singup/sing_up_cubit.dart';
import 'package:agri_guide_app/core/service/location_handler.dart';

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

  late double _latitude;
  late double _longitude;
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late LocationHandler _locationHandler;

  @override
  void initState() {
    super.initState();
    _locationHandler = LocationHandler(
      showSnack: _showSnack,
      onLocationObtained: (lat, lng, cityName) {
        setState(() {
          _latitude = lat;
          _longitude = lng;
          _locationController.text = cityName;
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

  SingupEntity _buildEntity() {
    return SingupEntity(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      cityName: _locationController.text.trim(),
      longitude:_longitude, 
      latitude: _latitude,
    );
  }

  void _showSnack(String text, Color? color) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: theme.snackBarTheme.contentTextStyle,
        ),
        backgroundColor: color ?? theme.snackBarTheme.backgroundColor,
        behavior: theme.snackBarTheme.behavior,
        shape: theme.snackBarTheme.shape,
      ),
    );
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<SingUpCubit>().signup(_buildEntity(), context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<SingUpCubit, SingUpState>(
      listener: (context, state) {
        if (state is SingUpFailure) {
          _showSnack(state.errmessage, theme.colorScheme.error);
        }
        if (state is SingUpSuccess) {
          _showSnack('Account created successfully', theme.colorScheme.primary);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: theme.scaffoldBackgroundColor,
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
                                  prefixIcon: Icon(Icons.person_outline, color: theme.iconTheme.color),
                                  validator: (v) =>
                                      AuthValidators.validateNotEmpty(v, "First Name"),
                                  isPassword: false,
                                ),
                                const Gap(15),
                                CustomeTextFormField(
                                  hintText: 'Enter your last name',
                                  labelText: 'Last Name',
                                  controller: _lastNameController,
                                  prefixIcon: Icon(Icons.person_outline, color: theme.iconTheme.color),
                                  validator: (v) =>
                                      AuthValidators.validateNotEmpty(v, "Last Name"),
                                  isPassword: false,
                                ),
                                const Gap(15),
                                CustomeTextFormField(
                                  hintText: 'Enter your email',
                                  labelText: 'Email',
                                  controller: _emailController,
                                  prefixIcon: Icon(Icons.email, color: theme.iconTheme.color),
                                  validator: AuthValidators.validateEmail,
                                  isPassword: false,
                                ),
                                const Gap(15),
                                CustomeTextFormField(
                                  hintText: 'Create password',
                                  labelText: 'Password',
                                  controller: _passwordController,
                                  prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color),
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
                                      color: theme.iconTheme.color,
                                    ),
                                  ),
                                ),
                                const Gap(15),
                                CustomeTextFormField(
                                  hintText: 'Confirm password',
                                  labelText: 'Confirm Password',
                                  controller: _confirmPasswordController,
                                  prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color),
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
                                        _obscureConfirmPassword = !_obscureConfirmPassword;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: theme.iconTheme.color,
                                    ),
                                  ),
                                ),
                                const Gap(15),
                                LocationField(
                                  controller: _locationController,
                                  isLoading: _locationHandler.isLoading,
                                  onTap: _locationHandler.getLocation,
                                ),
                                const Gap(40),
                                CustomAuthButton(
                                  isLoading: state is SingUpLoading,
                                  onPressed: _signup,
                                  text: 'Sign Up',
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account?', style: theme.textTheme.bodyMedium),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => const LoginView()),
                                        );
                                      },
                                      child: Text(
                                        ' Log in',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
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
              if (state is SingUpLoading)
                Container(
                  color: theme.colorScheme.onSurface.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}