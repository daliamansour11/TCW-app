import 'package:flutter/material.dart';

Widget buildActionButton({
  required dynamic icon,
  String label = '',
  VoidCallback? onPressed,
  Color iconColor = Colors.white,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Column(
      children: [
        if (icon is IconData)
          Icon(icon, size: 32, color: iconColor)
        else
          ImageIcon(
            AssetImage(icon.toString()),
            size: 32,
            color: iconColor,
          ),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}