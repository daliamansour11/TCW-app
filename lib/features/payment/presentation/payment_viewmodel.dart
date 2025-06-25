import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:zap_sizer/zap_sizer.dart';

class PaymentViewmodel {
  PaymentViewmodel(this.ctx);
  BuildContext ctx;

  void paymentSuccessDialog() {
    customIconDialog(
      ctx,
      title: 'Payment Successful!',
      subTitle: 'Your enrollment in the program has been confirmed.',
      buttons: CustomIconDialogButtons(
        firstTitle:null,
        secondTitle: 'Start Program',
        secondWidth: 50.w,
        secondOnPressed: () {},
      ),
   
    );
  }
}
