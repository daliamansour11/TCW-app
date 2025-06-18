// core/shared/shared_widget/Custom_button.dart
// ignore_for_file: use_super_parameters// ignore_for_file: use_super_parameters, use_super_parameters

import 'package:flutter/material.dart';
import 'package:tcw/core/theme/app_colors.dart';



// Custom button
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final Color? backgroundColor;
  final double? radius;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool? hasSahdow;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // padding: EdgeInsets.symmetric(vertical: context.propHeight(15)),
      minWidth: width ?? double.infinity,
      height: height,
      elevation: hasSahdow == true ? 2 : 0,

      color: backgroundColor ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 25),
      ),
      onPressed: onPressed,
      child: Text(title, style: style),
    );
  }
}
