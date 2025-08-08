import 'package:flutter/material.dart';

class NotificationModel {
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      icon: _mapIcon(json['icon']),
      iconBackground: _hexToColor(json['icon_background']),
      bulletPoints: (json['bullet_points'] as List<dynamic>?)
          ?.map((bp) => BulletPoint(
        bp['bold_text'] ?? '',
        bp['normal_text'] ?? '',
      ))
          .toList() ??
          [],
      navigationType: json['navigation_type'] ?? '',
      targetId: json['target_id'] ?? 0,
      actionText: json['action_text'] ?? '',
      isRead: json['is_read'] ?? false, id: json['id']??0  ,

    );
  }

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.icon,
    required this.iconBackground,
    required this.bulletPoints,
    required this.navigationType,
    required this.targetId,
    required this.actionText,
    this.isRead = false,
  });
  final int id;
  final String title;
  final String subtitle;
  final DateTime createdAt;
  final IconData icon;
  final Color iconBackground;
  final List<BulletPoint> bulletPoints;
  final String navigationType;
  final int targetId;
  final String actionText;
  bool isRead;


  /// helper: map icon string to IconData
  static IconData _mapIcon(String? iconName) {
    switch (iconName) {
      case 'notifications':
        return Icons.notifications;
      case 'school':
        return Icons.school;
      case 'event':
        return Icons.event;
      case 'message':
        return Icons.message;
      default:
        return Icons.notifications_none;
    }
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}

class BulletPoint {
  BulletPoint(this.boldText, this.normalText);
  final String boldText;
  final String normalText;
}
