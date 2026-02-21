import 'package:agri_guide_app/feature/auth/view/login_view.dart';
import 'package:agri_guide_app/feature/onboard/view/onboard_view.dart';
import 'package:agri_guide_app/feature/onboard/widgets/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OnboardView()),
        );
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
    const Color primaryGreen = Color(0xFF008236);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
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
                    width: 130,
                    height: 130,
                    colorFilter: const ColorFilter.mode(
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
                      child: const Text(
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