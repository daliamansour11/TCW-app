import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/models/onbording_model.dart';
import 'package:tcw/routes/routes_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex == onboardingPages.length - 1) {
      // Navigate to main screen or login
     Modular.to.pushReplacementNamed(AppRoutes.loginPage);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: AssetManger.onBording_1,
      title: 'Start Your Learning Journey!',
      description:
          'Explore a learning platform designed just for you. Join study groups, complete tasks, and track your progress effortlessly.',
    ),
    OnboardingModel(
      image: AssetManger.onBording_2,
      title: 'Learn Smarter, Not Harder!',
      description:
          'Save time with the "Mind Master" system, where you can join private groups and engage with educational content without distractions.',
    ),
    OnboardingModel(
      image: AssetManger.onBording_3,
      title: 'All Your Tools in One Place!',
      description:
          'From your dashboard to progress tracking, we’ve designed a seamless experience to keep your learning organized and efficient.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == onboardingPages.length - 1;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final page = onboardingPages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isLast)
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Modular.to.pushReplacementNamed(AppRoutes.loginPage);
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 60),
                      CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.grey.shade100,
                        child: CircleAvatar(
                          radius: 110,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: Image.asset(
                              page.image,
                              width: context.propWidth(180),
                              height: context.propHeight(180),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.propHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingPages.length,
                          (dotIndex) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: context.propHeight(8),
                            width: _currentIndex == dotIndex ? 20 : 8,
                            decoration: BoxDecoration(
                              color: _currentIndex == dotIndex
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.propHeight(24)),
                      Text(
                        page.title,
                        style: context.textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.propHeight(12)),
                      Text(
                        page.description,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                isLast ? "Get Started" : "Continue",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
