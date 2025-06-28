// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:zap_sizer/zap_sizer.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.data, {
    super.key,
    this.color,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.decoration,
    this.fontType = FontType.Lato,
  });
  final FontType fontType;
  final String data;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: key,
      style: _getStyle(
        color: color,
        context: context,
        decoration: decoration,
        fontSize: fontSize,
        fontType: fontType,
        letterSpacing: letterSpacing,
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }

  static TextStyle style({
    FontWeight? fontWeight,
    FontType fontType = FontType.Lato,
    Color? color,
    double? letterSpacing,
    double? fontSize,
    TextDecoration? decoration,
    BuildContext? context,
  }) =>
      _getStyle(
        color: color,
        context: context,
        decoration: decoration,
        fontSize: fontSize,
        fontType: fontType,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      );
}

double? _getFontSize(
  BuildContext? context,
  double? fontSize,
) {
  if (context?.findAncestorWidgetOfExactType<AppBar>() != null) {
    return fontSize ?? 18;
  }

  return fontSize;
}

FontWeight? _getFontWeight(BuildContext? context, {FontWeight? fontWeight}) {
  if (context?.findAncestorWidgetOfExactType<AppBar>() != null) {
    return fontWeight ?? FontWeight.w700;
  }
  return fontWeight;
}

Color? _getColor(Color? color) {
  return color;
}

TextStyle _getStyle({
  FontType fontType = FontType.Lato,
  Color? color,
  double? letterSpacing,
  double? fontSize,
  TextDecoration? decoration,
  BuildContext? context,
  FontWeight? fontWeight,
}) {
  switch (fontType) {
    case FontType.Lato:
      return GoogleFonts.lato(
        color: _getColor(color),
        letterSpacing: letterSpacing,
        fontSize: _getFontSize(context, fontSize)?.sp,
        fontWeight: _getFontWeight(context, fontWeight: fontWeight),
        decoration: decoration,
      );
    case FontType.NoneFont:
      return TextStyle(
        color: _getColor(color),
        letterSpacing: letterSpacing,
        fontSize: _getFontSize(context, fontSize)?.sp,
        fontWeight: _getFontWeight(context, fontWeight: fontWeight),
        decoration: decoration,
      );
    case FontType.Noto:
      return GoogleFonts.notoSans(
        color: _getColor(color),
        letterSpacing: letterSpacing,
        fontSize: _getFontSize(context, fontSize)?.sp,
        fontWeight: _getFontWeight(context, fontWeight: fontWeight),
        decoration: decoration,
      );
      case FontType.Poppins:
          return GoogleFonts.poppins(
        color: _getColor(color),
        letterSpacing: letterSpacing,
        fontSize: _getFontSize(context, fontSize)?.sp,
        fontWeight: _getFontWeight(context, fontWeight: fontWeight),
        decoration: decoration,
      );
  }
}

enum FontType { NoneFont, Lato, Noto ,Poppins}
