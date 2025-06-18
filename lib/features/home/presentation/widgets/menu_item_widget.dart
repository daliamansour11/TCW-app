import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const MenuItem({
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: 24,
        height: 24,
      ),
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black)),
      onTap: onTap
    );
  }
}
