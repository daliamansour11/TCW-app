import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton.icon({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
    this.removeWidth = false,
    this.padding,
    this.textColor,
    this.border,
    this.borderColor,
    this.iconAlignment,
    }) : withIcon = true;
//
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
    this.border,
    this.removeWidth = false,
    this.padding,
    this.borderColor,
    this.textColor,
  })  : withIcon = false,
        icon = null,
        iconAlignment = IconAlignment.end;
  final Widget? icon;
  final bool withIcon;
  final String title;
  final Color? textColor;
  final Function() onPressed;
  final Color? backgroundColor, borderColor;
  final BorderSide? border;
  final double? radius;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool? hasSahdow;
  final EdgeInsets? padding;
  final bool removeWidth;
  final IconAlignment? iconAlignment;
  @override
  Widget build(BuildContext context) {
    if (withIcon) {
      return ElevatedButton.icon(
        icon: icon,
        iconAlignment: iconAlignment ?? IconAlignment.end,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(padding),
          elevation: WidgetStatePropertyAll(hasSahdow == true ? 2 : 0),
          backgroundColor:
              WidgetStatePropertyAll(backgroundColor ?? Colors.black),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 25),
        side: borderColor == null && border == null
            ? BorderSide.none
              :border?? BorderSide(color: borderColor ?? Colors.black,width: 1),
          )),
        ),
        onPressed: onPressed,
        label: CustomText(
          title,
          color: textColor ?? style?.color ?? Colors.white,
          fontSize: style?.fontSize ?? 14,
          fontWeight: style?.fontWeight ?? FontWeight.w500,
          letterSpacing: style?.letterSpacing,
          decoration: style?.decoration,
        ),
      );
    }
    return MaterialButton(
      padding: padding,
      // padding: EdgeInsets.symmetric(vertical: context.propHeight(15)),
      minWidth: removeWidth ? null : (width ?? double.infinity),
      height: height,
      elevation: hasSahdow == true ? 2 : 0,

      color: backgroundColor ?? Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 25),
        side: borderColor == null && border == null
            ? BorderSide.none
              :border?? BorderSide(color: borderColor ?? Colors.transparent,width: 1),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: textColor ?? style?.color ?? Colors.white,
          fontSize: style?.fontSize ?? 14,
          fontWeight: style?.fontWeight ?? FontWeight.w500,
          fontFamily: style?.fontFamily,
          letterSpacing: style?.letterSpacing,
          height: style?.height,
          decoration: style?.decoration,
        ),
      ),
    );
  }
}
