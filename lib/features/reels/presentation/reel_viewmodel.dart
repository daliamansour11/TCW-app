import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';

class ReelViewmodel {
  ReelViewmodel(this.context);
  BuildContext context;

  /// create reel
  void onPostReel() {
    customIconDialog(
      context,
      title: 'Reel Posted Successfully',
      subTitle: 'You’ve earned 500 points — keep going, more rewards await!',
      buttons: CustomIconDialogButtons(
        firstTitle: 'Check My Points',
        secondTitle: 'Watch My Reel',
        firstOnPressed: () {},
        secondOnPressed: () {},
      ),
    );
  }
}
