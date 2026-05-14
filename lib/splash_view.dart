import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/onboard/view/onboard_view.dart';
import 'package:agri_guide_app/feature/home/presentation/view/home_view.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final session = Supabase.instance.client.auth.currentSession;
        final user = Supabase.instance.client.auth.currentUser;

        if (session != null && user != null) {
          final profileData = await Supabase.instance.client
              .from('profiles')
              .select(
                'id, email, first_name, last_name, city_name, latitude, longitude',
              )
              .eq('id', user.id)
              .maybeSingle();

          if (mounted) {
            if (profileData != null) {
              final loginEntity = LoginEntity(
                id: profileData['id'],
                email: profileData['email'],
                password: '',
                firstName: profileData['first_name'] ?? '',
                lastName: profileData['last_name'] ?? '',
                cityName: profileData['city_name'] ?? '',
                latitude: (profileData['latitude'] ?? 0).toDouble(),
                longitude: (profileData['longitude'] ?? 0).toDouble(),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    // ✅ نفس اللي بيحصل في Login
                    create: (_) => ProfileCubit(userId: loginEntity.id)
                      ..getProfileData(),
                    child: HomeView(loginEntity: loginEntity),
                  ),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => OnboardView()),
              );
            }
          }
        } else {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => OnboardView()),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Theme.of(context).colorScheme.primary;
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: backgroundColor),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 100,
                    height: 100,
                    colorFilter: ColorFilter.mode(
                      primaryGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        'Agri guide',
                        style: TextStyle(
                          color: primaryGreen,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Text(
                        'Your Agricultural Guide',
                        style: TextStyle(
                          color: primaryGreen.withOpacity(0.7),
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}