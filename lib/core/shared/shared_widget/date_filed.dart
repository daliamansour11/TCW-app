/* // core/shared/shared_widget/date_filed.dart
import 'package:flutter/material.dart';
import 'package:khayyl/core/constansts/asset_manger.dart';
import 'package:khayyl/core/constansts/context_extensions.dart';
import 'package:khayyl/core/shared/shared_widget/customTextFormFiled.dart';
import 'package:khayyl/core/theme/app_Theme.dart';
import 'package:khayyl/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;

  const DateField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DateOfBirth'.tr(),
          style: AppTheme(context).theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.propHeight(18)),
        CustomTextField(
          suffix: Image.asset(
            AssetManger.calender,
          ),
          prefix: InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((value) {
                if (value != null) {
                  controller.text = value.toString().substring(0, 10);
                }
              });
            },
            child: Image.asset(
              AssetManger.arrowDown,
              color: AppColors.primaryColor,
            ),
          ),
          fillColor: const Color(0xFFF7F9FA),
          controller: controller,
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your birth date';
            }
            return null;
          },
          hintText: 'Enter your birth date',
          hintStyle: AppTheme(context).theme.inputDecorationTheme.hintStyle,
          obscureText: false,
        ),
      ],
    );
  }
}
 */