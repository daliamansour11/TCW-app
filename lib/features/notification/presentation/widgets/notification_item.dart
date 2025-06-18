import 'package:flutter/material.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: notification.iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(notification.icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(notification.subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Date Text
          Text(notification.date,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
