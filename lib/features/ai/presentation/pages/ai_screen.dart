import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/ai/presentation/widgets/ai_field_widget.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkGreen,
      appBar: CustomAppBar(
        title: '',
        backgroundColor: AppColors.darkGreen,
        backIconColor: Colors.white,
      ),
      body:  Column(
        spacing: 8,
        children: [
          CustomContainer(
             gradient: AppColors.cardGradient,
             isCircle: true,
            child: CustomImage(
            AssetUtils.chatBot,
          ),
          ),
          CustomText(
            'WELCOME TO TCW Bot',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          CustomText(
            'How can I help you today?',
            color: Colors.white,
            fontSize: 16,
          ),
          Spacer(),
          AiFieldWidget(),
        ],
      ),
    );
  }
}
