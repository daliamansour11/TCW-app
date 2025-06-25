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
    return const CustomContainer(
      borderRadius: 16,
      fullPadding: EdgeInsets.all(10),
      color: Color.fromRGBO(183, 146, 79, 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          CustomText(
            'Create a Reel and earn 500 points!',
            color: AppColors.primaryColor,
          ),
       CustomImage(
            AssetUtils.notoPartyingFace,
          )
        ],
      ),
    );
  }
}
