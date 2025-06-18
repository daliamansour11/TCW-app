/* // core/shared/shared_widget/password_field.dart
import 'package:flutter/material.dart';
import 'package:khayyl/core/constansts/asset_manger.dart';
import 'package:khayyl/core/constansts/context_extensions.dart';
import 'package:khayyl/core/shared/shared_widget/customTextFormFiled.dart';
import 'package:khayyl/core/theme/app_Theme.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String titel;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.titel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titel,
          style: AppTheme(context).theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.propHeight(18)),
        CustomTextField(
          suffix: Image.asset(
            AssetManger.lock,
          ),

          // height: context.propHeight(52),
          fillColor: const Color(0xFFF7F9FA),
          obscureText: true,
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          hintText: 'Enter your password',
          hintStyle: AppTheme(context).theme.inputDecorationTheme.hintStyle,
        ),
      ],
    );
  }
}
 */