import 'package:bone_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final PageController _pageController = PageController();

  ImageCarousel({super.key});

  // Function to check if onboarding was shown before
  Future<bool> _isOnboardingShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingShown') ?? false; // Defaults to false if not set
  }

  // Function to set the onboarding as shown
  Future<void> _setOnboardingShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingShown', true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isOnboardingShown(),
      builder: (context, snapshot) {
        // Show loading indicator while waiting for SharedPreferences check
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If onboarding was already shown, navigate to the Login screen directly
        if (snapshot.data == true) {
          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return Container(); // Return empty container while navigating
        }

        // Show onboarding screen if it wasn't shown before
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: _pageController,
                children: [
                  ImagePage(
                    imagePath: 'lib/assets/Onboarding1.png', // First page
                    onSkip: () async {
                      // Mark onboarding as shown and navigate to Login screen
                      await _setOnboardingShown();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  ImagePage(
                    imagePath: 'lib/assets/Onboarding2.png', // Second page
                    onSkip: () async {
                      // Mark onboarding as shown and navigate to Login screen
                      await _setOnboardingShown();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  ImagePage(
                    imagePath: 'lib/assets/Onboarding3.png', // Last page
                    isLastPage: true,
                    onLastPageComplete: () async {
                      // Mark the onboarding as shown when "Get Started" is pressed
                      await _setOnboardingShown();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImagePage extends StatelessWidget {
  final String imagePath;
  final bool isLastPage;
  final VoidCallback? onSkip;
  final VoidCallback? onLastPageComplete; // Add a callback for the last page

  const ImagePage({
    Key? key,
    required this.imagePath,
    this.isLastPage = false,
    this.onSkip,
    this.onLastPageComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        if (!isLastPage)
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: onSkip,
              child: const Text(
                'Skip',
              ),
            ),
          ),
        if (isLastPage)
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: onLastPageComplete,
              child: const Text('Get Started'),
            ),
          ),
      ],
    );
  }
}


