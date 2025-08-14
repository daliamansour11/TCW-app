import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';

class ReelEarnPointsWidget extends StatelessWidget {
  const ReelEarnPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
      borderRadius: 16,
      fullPadding:const EdgeInsets.all(10),
      color:const Color.fromRGBO(183, 146, 79, 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          CustomText(
            'reel.Create_Reel_earn_points'.tr(),
            color: AppColors.primaryColor,
          ),
    const   CustomImage(
            AssetUtils.notoPartyingFace,
          )
        ],
      ),
    );
  }
}
