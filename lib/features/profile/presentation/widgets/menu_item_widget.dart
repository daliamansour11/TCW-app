import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
    this.onTap,
  });
  final dynamic icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: icon is String
            ? Image.asset(
                icon,
                width: 24,
                height: 24,
              )
            : Icon(icon,color: iconColor,size: 24,),
        
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black,
          ),
        ),
        onTap: onTap);
  }
}
