import 'package:flutter/widgets.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:zapx/zapx.dart';

class PointsViewmodel {
  PointsViewmodel(this.context);
  late BuildContext context;

  void onRedeemReward() {
    customIconDialog(
      context,
      title:
          'Are you sure you want to redeem 100 points for a 10% discount on the program subscription?',
      icon: const SizedBox.shrink(),
      buttons:  CustomIconDialogButtons(
        firstTitle: 'Cancel',
        secondTitle: 'Redeem',
        secondOnPressed: () {
          Zap.back();
          onRedeemRewardSuccess();
        },
      ),
    );
  }

  void onRedeemRewardSuccess() {
    customIconDialog(
      context,
      title: 'Reward redeemed successfully',
      icon: const SizedBox.shrink(),
      buttons: const CustomIconDialogButtons(
        firstTitle: 'Back',
        secondTitle: 'Explore Programs',

      ),
    );
  }
}
