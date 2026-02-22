import 'package:agri_guide_app/feature/auth/view/login_view.dart';
import 'package:agri_guide_app/feature/onboard/widgets/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  late List<Widget> screans;
  int indexcurrent = 0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screans = [
     
      OnBoardingPage(
        imagePath: 'assets/onboard1.png',
        icon:PhosphorIcons.plant(),
        title: 'Welcome to Agri Guide',
        subtitle:
            'Your personal farming assistant. Get expert advice, weather updates, and crop management tools all in one place.',
      ),
      OnBoardingPage(
        imagePath: 'assets/onboard2.png',
        icon:  Icons.eco,
        title: 'AgriGuide ',
        subtitle:
            'Your AI-powered companion for healthy crops and sustainable farming',
      ),
       OnBoardingPage(
        imagePath: 'assets/onboard3.png',
        icon: Icons.camera_alt,
        title: 'Instant Plant Analysis',
        subtitle:
            'Take a photo of your plant and get instant disease diagnosis and treatment recommendations',
      ),
    ];
    _pageController = PageController(initialPage: indexcurrent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            setState(() {
              if (indexcurrent != 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            });
          },
          child: Text(
            indexcurrent == 0 ? "" : "Back",
            style: TextStyle(fontSize: 16, color: Colors.green),
            maxLines: 1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: screans.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            indexcurrent = value;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(child: screans[index]),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (indexcurrent < screans.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginView()),
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
                    indexcurrent == screans.length - 1 ? "Get Started" : "Next",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
