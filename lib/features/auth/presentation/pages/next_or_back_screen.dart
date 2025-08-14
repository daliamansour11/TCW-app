import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/theme/app_colors.dart';

class NextOrBackScreen extends StatelessWidget {
  const NextOrBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/next_or_back.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Buttons at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Back Button
                  CustomButton(
                    title: 'Back'.tr(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.scaffoldBackground,
                    radius: 10.0,
                    width: double.infinity,
                    height: size.height * 0.07,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  // Next Button
                  CustomButton(
                    title: 'Next'.tr(),
                    onPressed: () {
                      // Navigate to next screen
                    },
                    backgroundColor: AppColors.primaryColor,
                    radius: 10.0,
                    width: double.infinity,
                    height: size.height * 0.07,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
