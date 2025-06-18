import 'package:flutter/material.dart';

class AppNotification {
  final String title;
  final String subtitle;
  final String date; // e.g., "10 March, 10:00 AM"
  final IconData icon;
  final Color iconBackground;

  AppNotification({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.iconBackground,
  });
}
