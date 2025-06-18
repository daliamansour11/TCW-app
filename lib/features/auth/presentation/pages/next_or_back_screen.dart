

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/Custom_button.dart';
import 'package:tcw/core/theme/app_colors.dart';

class NextOrBackScreen extends StatelessWidget {


  const NextOrBackScreen({
    Key? key,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          SizedBox.expand(child: 
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/next_or_back.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
          ),
          Column(
            children: [
              
                SizedBox(height: size.height * 0.7),
            
              
              SizedBox(height: size.height * 0.02),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
              child: CustomButton(
                title: 'Next'.tr(),
                onPressed: () {},
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
            ),
          ),
               Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
              child: CustomButton(
                title: 'Next'.tr(),
                onPressed:  () {},
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
            ),
          ),
        ],
      ),
    );
  }
}
