import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:zapx/zapx.dart';

class NewCardScreen extends StatelessWidget {
  const NewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'New Card'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('Card number'),
            CustomTextField(
              maxLength: 16,
              keyboardType: TextInputType.number,
              hintText: 'Enter Your Card Number',
              suffixIcon: const Icon(Icons.credit_card),
              onChanged: (value) {},
              counterText: '',
            ),
            const CustomText('Card holder'),
            CustomTextField(
              hintText: 'Enter Name On Card',
              onChanged: (value) {},
            ),
            const Row(
              spacing: 10,
              children: [
                Flexible(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText('Expiry date'),
                      CustomTextField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        hintText: 'MM/YY',
                        counterText: '',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child:  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText('Security code'),
                      CustomTextField(
                        maxLength: 3,
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        hintText: 'CVV',
                        counterText: '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // save card or unSave ListTile Switch
            CheckboxListTile(
              value: true,
              title: const CustomText('Save card for future'),
              onChanged: (v) {},
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        title: 'Save Card',
        onPressed: () {},
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
