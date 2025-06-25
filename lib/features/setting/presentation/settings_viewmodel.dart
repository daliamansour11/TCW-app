import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:zapx/zapx.dart';

class SettingsViewmodel {
  SettingsViewmodel(this.context);
  final BuildContext context;

  showSuccessDialog(String msg) {
    customIconDialog(
      context,
      title: msg,
    );
  }

  // Suspend Account
  suspendAccount() {
    customIconDialog(
      context,
      title: 'Are you sure you want to suspend your account?',
      icon: const Icon(Icons.pause_circle_outline,size: 30,),
      buttons: CustomIconDialogButtons(
        firstTitle: 'Cancel',
        secondTitle: 'Suspend',
        firstOnPressed: Zap.back,
        secondOnPressed: () {
          Zap.back();
          showSuccessDialog('Your account has been suspended successfully.');
        },
      ),
    );
  }
}
