import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/onboard/widgets/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  late List<Widget> screens;
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    screens = [
      OnBoardingPage(
        imagePath: 'assets/onboard1.png',
        icon: PhosphorIcons.plant(),
        title: 'welcomeTitle',
        subtitle: 'welcomeSubtitle',
      ),
      OnBoardingPage(
        imagePath: 'assets/onboard2.png',
        icon: Icons.eco,
        title: 'agriGuide',
        subtitle: 'welcomeSubtitle', // لو عايز Subtitle مختلف اعمله key جديد
      ),
      OnBoardingPage(
        imagePath: 'assets/onboard3.png',
        icon: Icons.camera_alt,
        title: 'instantPlantAnalysis',
        subtitle: 'analysisSubtitle',
      ),
    ];
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
     print('========== LANGUAGE DEBUG ==========');
  print('Current locale: ${context.locale}');
  print('Language code: ${context.locale.languageCode}');
  print('Is Arabic: ${context.locale.languageCode == "ar"}');
  print('Welcome title translation: ${"welcomeTitle".tr()}');
  print('Next button translation: ${"next".tr()}');
  print('Skip button translation: ${"skip".tr()}');
  print('=====================================');
  
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            if (currentIndex != 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text(
            currentIndex == 0 ? "" : "back".tr(),
            style: const TextStyle(fontSize: 16, color: Colors.green),
            maxLines: 1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            child: Text(
              "skip".tr(),
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: screens.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(child: screens[index]),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentIndex < screens.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginView()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    currentIndex == screens.length - 1
                        ? 'getStarted'.tr()
                        : 'next'.tr(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}