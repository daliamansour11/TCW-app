// core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFB7924F);
  static const Color secondaryColor = Color(0xffFBD928);
  static const Color darkGreen = Color(0xFF0A241A);

  static const Color scaffoldBackground = Color(0xfffbfbfc);
  static const Color greyWhiteColor = Color.fromRGBO(238, 241, 246, 1);
  static const Color primaryTextColor = Color(0xFF202244);
  static const Color secondaryTextColor = Color(0xffFFFFFF);
  static const Color hintTextColor = Color.fromRGBO(0, 0, 0, 0.5);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color.fromRGBO(8, 15, 52, 0.06),
      blurRadius: 42,
      offset: Offset(0, 14),
    )
  ];

  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(23, 89, 65, 1),
      Color.fromRGBO(183, 146, 79, 1),
    ],
  );
}
