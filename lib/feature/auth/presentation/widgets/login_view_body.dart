import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/login/login_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/reset_password_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/signup_view.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/auth_validator.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/presentation/widgets/custome_auth_buttom.dart';
import 'package:agri_guide_app/feature/home/presentation/view/home_view.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.email, required this.password});
  final String? email;
  final String ?password;

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    final entity = LoginEntity(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    context.read<LoginCubit>().login(userData: entity, context: context);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text=widget.email??'';
    _passwordController.text=widget.password??'';
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errmessage),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) =>
                    ProfileCubit(userId: state.userData.id!)..getProfileData(),
                child: HomeView(loginEntity: state.userData),
              ),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
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
                                  'loginWithEmail'.tr(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Gap(50),

                              CustomeTextFormField(
                                hintText: 'enterYourEmail',
                                labelText: 'email',
                                prefixIcon: Icon(Icons.email,
                                    color: theme.iconTheme.color),
                                controller: _emailController,
                                validator: AuthValidators.validateEmail,
                                isPassword: false,
                              ),

                              const Gap(30),

                              CustomeTextFormField(
                                hintText: 'enterYourPassword',
                                labelText: 'password',
                                prefixIcon: Icon(Icons.lock,
                                    color: theme.iconTheme.color),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(
                                      () => _obscureText = !_obscureText),
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                controller: _passwordController,
                                isPassword: _obscureText,
                                validator: AuthValidators.validatePassword,
                              ),

                              const Gap(10),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ResetPasswordView(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'forgotPassword'.tr(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),

                              const Gap(30),

                              CustomAuthButton(
                                text: 'login'.tr(),
                                isLoading: state is LoginLoading,
                                onPressed: _login,
                              ),

                              const Gap(20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'dontHaveAccount'.tr(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color:
                                          theme.colorScheme.onSurfaceVariant,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const SignupView(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'signUp'.tr(),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: theme.colorScheme.primary,
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