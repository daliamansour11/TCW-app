import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_theme.dart';
import 'package:tcw/core/theme/app_colors.dart';

enum FieldType {
  date,
  text,
  dropdown,
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.fillColor,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.errorMessage,
    this.hintStyle,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.borderColor,
    this.fieldType = FieldType.text,
    this.backgroundColor,
    // Date Picker
    this.firstDate,
    this.lastDate,
    this.onDateSelected,

    // Suffix and Prefix
    this.suffixIcon,
    this.prefixIcon,

    // Dropdown
    this.items,
    this.onChanged,
    this.borderRadius,
    this.textColor,
    this.counterText,
  });
  final FieldType fieldType;
  final Color? fillColor, borderColor, backgroundColor;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final TextStyle? hintStyle;
  final bool obscureText;
  final int? maxLines, minLines, maxLength;
  final DateTime? firstDate, lastDate;
  final void Function(DateTime?)? onDateSelected;
  final Widget? suffixIcon, prefixIcon;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final double? borderRadius;
  final Color? textColor;
  final String? counterText;
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? 10.0);
    final decoration = InputDecoration(
      errorStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.red,
      ),
      fillColor: backgroundColor ?? Colors.white,
      filled: true,
      hintText: hintText,
      hintStyle: hintStyle??CustomText.style(
        color: textColor,
      ),
      counterText:counterText ,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelStyle: CustomText.style(
        color: textColor,
      ),
      prefixStyle: CustomText.style(
        color: textColor,
      ),
      suffixStyle: CustomText.style(
        color: textColor,
      ),
      labelText: labelText,
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: borderColor ?? Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: borderColor ?? Colors.grey,
        ),
      ),
      contentPadding: EdgeInsets.only(
        bottom: context.propHeight(15),
        right: context.propWidth(14),
        left: context.propWidth(14),
      ),
    );
    if (fieldType == FieldType.dropdown) {
      return DropdownButtonFormField(
        items: items
            ?.map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: decoration,
        validator: validator,
        value: controller?.text,
      );
    }
    if (fieldType == FieldType.date) {
      return TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: decoration,
        style: AppTheme(context)
            .theme
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.primaryTextColor),
        readOnly: true,
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            firstDate: firstDate ??
                DateTime.now().subtract(
                  const Duration(days: 365),
                ),
            lastDate: lastDate ??
                DateTime.now().add(
                  const Duration(days: 365),
                ),
          );
          if (date != null) {
            onDateSelected?.call(date);
          }
        },
      );
    }
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      minLines: minLines,
      maxLength: maxLength,
      style: AppTheme(context)
          .theme
          .textTheme
          .bodyLarge
          ?.copyWith(color: textColor ?? AppColors.primaryTextColor),
      decoration: decoration,
    );
  }
}
