import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/models/onbording_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextPage() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentIndex == onboardingPages.length - 1) {
      await prefs.setBool('hasSeenOnboarding', true);
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
      image: AssetUtils.onBording_1,
      title: 'onboarding.title1'.tr(),
      description: 'onboarding.desc1'.tr(),
    ),
    OnboardingModel(
      image: AssetUtils.onBording_2,
      title: 'onboarding.title2'.tr(),
      description: 'onboarding.desc2'.tr(),
    ),
    OnboardingModel(
      image: AssetUtils.onBording_3,
      title: 'onboarding.title3'.tr(),
      description: 'onboarding.desc3'.tr(),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final page = onboardingPages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentIndex != 0)
                            IconButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          if (!isLast)
                            TextButton(
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('hasSeenOnboarding', true);
                                Modular.to.pushReplacementNamed(AppRoutes.loginPage);
                              },
                              child: Text('onboarding.skip'.tr(),
                                  style: const TextStyle(color: Colors.black)),
                            ),
                        ],
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
                isLast ? 'onboarding.get_started'.tr() : 'onboarding.continue'.tr(),
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
