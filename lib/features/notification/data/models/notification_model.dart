import 'package:flutter/material.dart';


class NotificationModel {

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.icon,
    required this.iconBackground,
  });
  final String title;
  final String subtitle;
  final DateTime createdAt;
  final IconData icon;
  final Color iconBackground;
}
