import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/riyal_logo.dart';
import 'package:tcw/features/payment/presentation/payment_viewmodel.dart';
import 'package:tcw/features/payment/presentation/widgets/payment_method_section.dart';
import 'package:tcw/features/payment/presentation/widgets/subscription_section.dart';
import 'package:zapx/zapx.dart';

class ProccessPayScreen extends StatefulWidget {
  const ProccessPayScreen({super.key});

  @override
  State<ProccessPayScreen> createState() => _ProccessPayScreenState();
}

class _ProccessPayScreenState extends State<ProccessPayScreen> {
     late final PaymentViewmodel viewmodel;
   @override
  void initState() {
    super.initState();
    viewmodel=  PaymentViewmodel(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Payment'
      ),
      body:const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            // TODO Add Preview for the will payment
            PaymentMethodSection(),
            SubscriptionSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton.icon(
        title: 'Pay 2000',
        style: CustomText.style(fontSize: 17),
        padding:const EdgeInsets.all(15),
        backgroundColor: Colors.black,
        icon: const RiyalLogo(color: Colors.white),
        onPressed: viewmodel.paymentSuccessDialog,
      ).paddingAll(5));
  }
}