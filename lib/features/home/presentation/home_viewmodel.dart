import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:zapx/zapx.dart';

class HomeViewmodel {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void logOutDialog(BuildContext context) {
    customIconDialog(context,
        title: 'Are You Surce You Want To Log Out?',
        icon: const Icon(
          Icons.logout_outlined,
          color: Colors.red,
        ),
        buttons: CustomIconDialogButtons(
            firstTitle: 'Cancel',
            secondTitle: 'Log Out',
            firstOnPressed: Zap.back,
            secondOnPressed: () {}),
      
        );
  }
}
