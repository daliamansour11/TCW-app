/* // core/shared/shared_widget/phone_number_filed.dart

// ignore_for_file: prefer_const_constructors

import 'package:khayyl/core/constansts/asset_manger.dart';
import 'package:khayyl/core/constansts/context_extensions.dart';
import 'package:khayyl/core/shared/shared_widget/customTextFormFiled.dart';
import 'package:khayyl/core/theme/app_Theme.dart';
import 'package:khayyl/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController phoneController;
  final FlCountryCodePicker countryPicker = const FlCountryCodePicker(
    countryTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Almarai',
      color: Colors.black,
    ),
    dialCodeTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Almarai',
      color: Colors.black,
    ),
  );

  final Function(CountryCode?) onCountryCodeSelected;

  const PhoneNumberField({
    super.key,
    required this.phoneController,
    required this.onCountryCodeSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  CountryCode? countryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone'.tr(),
          style: AppTheme(context).theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.propHeight(24)),
        CustomTextField(
          prefix: Container(
            padding: EdgeInsets.only(right: context.propWidth(6)),
            width: context.propWidth(52),
            child: GestureDetector(
              onTap: () async {
                final code = await widget.countryPicker.showPicker(
                  context: context,
                );

                setState(() {
                  countryCode = code;
                  widget.onCountryCodeSelected(countryCode);
                });
              },
              child: Row(
                children: [
                  SizedBox(
                    width: context.propWidth(20),
                    height: context.propHeight(20),
                    child: Image.asset(
                      AssetManger.arrowDown,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: context.propWidth(2),
                  ),
                  SizedBox(
                    height: context.propHeight(20),
                    child: countryCode != null
                        ? CountryCodeFlagWidget(
                            countryCode: countryCode!,
                            width: context.propWidth(20),
                            alignment: Alignment.centerLeft,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
          suffix: Image.asset(
            AssetManger.phone,
          ),
          fillColor: const Color(0xFFF7F9FA),
          controller: widget.phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter your phone number';
            }
            return null;
          },
          hintText: 'Enter your phone number',
          hintStyle: AppTheme(context).theme.inputDecorationTheme.hintStyle,
          obscureText: false,
        ),
      ],
    );
  }
}
 */