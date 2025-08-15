import 'package:flutter/material.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_image.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/asset_utils.dart';
import '../widgets/ai_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/ai_services.dart';
import '../cubit/ai_cubit.dart';
import '../widgets/ai_field_widget.dart';

import 'package:easy_localization/easy_localization.dart';
class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiCubit(AiService()),
      child: Scaffold( // remove const
        backgroundColor: AppColors.darkGreen,
        appBar: const CustomAppBar(
          title: '',
          backgroundColor: AppColors.darkGreen,
          backIconColor: Colors.white,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            CustomContainer(
              gradient: AppColors.cardGradient,
              isCircle: true,
              child: CustomImage(AssetUtils.chatBot),
            ),
            CustomText(
              'welcome_bot'.tr(),
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              'how_can_i_help'.tr(),
              color: Colors.white,
              fontSize: 16,
            ),
            const Spacer(),
            const AiFieldWidget(),
          ],
        ),
      ),
    );
  }
}

