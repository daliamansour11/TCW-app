import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/date_extensions.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});
  final NotificationModel notification;

  void handleNavigation(BuildContext context) {
    switch (notification.navigationType) {
      case 'course':
        Modular.to.pushNamed('/course/${notification.targetId}');
        break;
      case 'lesson':
        Modular.to.pushNamed('/lesson/${notification.targetId}');
        break;
      case 'program':
        Modular.to.pushNamed('/program/${notification.targetId}');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NotificationCubit>().markNotificationAsRead(notification);
        handleNavigation(context);
      },


      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
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
            // Text
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
            Text(notification.createdAt.formatDateByYears,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
