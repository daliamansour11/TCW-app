import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveText {
  static double responsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    // You can adjust the multiplier based on your design requirements
    double scaleFactor =
        screenWidth / 375.0; // Assuming the base design width is 375.0

    return (baseSize * scaleFactor).roundToDouble();
  }
}

class AppTheme {
  final BuildContext context;
  AppTheme(this.context);
  ThemeData get theme => ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.lato(
           fontSize: ResponsiveText.responsiveFontSize(context, 24),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
          headlineMedium: GoogleFonts.lato(
            fontSize: ResponsiveText.responsiveFontSize(context, 28),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
          headlineSmall: GoogleFonts.lato(
            fontSize: ResponsiveText.responsiveFontSize(context, 16),
            fontWeight: FontWeight.w400,
            color: AppColors.primaryTextColor,
          ),
         
        ),
      );
}
