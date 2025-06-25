import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';

class ReelAddVideoWidget extends StatelessWidget {
  const ReelAddVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomContainer(
      width: double.infinity,
      color: Colors.white,
      borderRadius: 20,
      boxShadow: AppColors.cardShadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          SizedBox.shrink(),
          Icon(Icons.video_call, size: 50, color: Colors.grey),
          CustomText(
            'Add the Video here',
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          CustomText(
            'Click the video icon to add a video',
            color: AppColors.hintTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
