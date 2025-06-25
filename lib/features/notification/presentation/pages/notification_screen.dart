import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';
import 'package:tcw/features/notification/presentation/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<NotificationModel> allNotifications = [
    NotificationModel(
      title: 'Resume Your Lesson!',
      subtitle: 'Get back on track!',
      createdAt: DateTime.now(),
      icon: Icons.play_circle,
      iconBackground: Colors.brown.shade100,
    ),
    NotificationModel(
      title: 'Congratulations',
      subtitle: "You successfully completed this week's challenge.",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.check_circle,
      iconBackground: Colors.amber.shade100,
    ),
    NotificationModel(
      title: 'New Message!',
      subtitle: 'Check your inbox now.',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      icon: Icons.chat_bubble_outline,
      iconBackground: Colors.orange.shade100,
    ),
    NotificationModel(
      title: 'Event Starting Soon!',
      subtitle: "Begins in 10 minutes. Don't miss out!",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      icon: Icons.event,
      iconBackground: Colors.brown.shade100,
    ),
    NotificationModel(
      title: 'Live Now!',
      subtitle: "You successfully completed this week's challenge.",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      icon: Icons.wifi_tethering,
      iconBackground: Colors.pink.shade100,
    ),
    NotificationModel(
      title: 'Live Session Ended!',
      subtitle: 'You can still watch it here',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      icon: Icons.stop_circle,
      iconBackground: Colors.brown.shade100,
    ),
    NotificationModel(
      title: 'Renew Your Subscription!',
      subtitle: 'Subscription Expires On 10 March! Renew Now',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      icon: Icons.refresh,
      iconBackground: Colors.brown.shade100,
    ),
    NotificationModel(
      title: 'Old Notification',
      subtitle: 'From last month!',
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
      icon: Icons.history,
      iconBackground: Colors.grey.shade300,
    ),
    NotificationModel(
      title: 'Last Year Reminder',
      subtitle: 'Check last year logs.',
      createdAt: DateTime.now().subtract(const Duration(days: 370)),
      icon: Icons.access_time,
      iconBackground: Colors.grey.shade200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final List<NotificationModel> today = [];
    final List<NotificationModel> yesterday = [];
    final List<NotificationModel> lastWeek = [];
    final List<NotificationModel> lastMonth = [];
    final List<NotificationModel> lastYear = [];

    for (var notif in allNotifications) {
      final diff = now.difference(notif.createdAt);
      if (diff.inDays == 0) {
        today.add(notif);
      } else if (diff.inDays == 1) {
        yesterday.add(notif);
      } else if (diff.inDays <= 7) {
        lastWeek.add(notif);
      } else if (diff.inDays <= 30) {
        lastMonth.add(notif);
      } else {
        lastYear.add(notif);
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notification',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (today.isNotEmpty) ...[
              const Text('Today', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...today.map((notif) => NotificationItem(notification: notif)),
              const SizedBox(height: 24),
            ],
            if (yesterday.isNotEmpty) ...[
              const Text('Yesterday', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...yesterday.map((notif) => NotificationItem(notification: notif)),
              const SizedBox(height: 24),
            ],
            if (lastWeek.isNotEmpty) ...[
              const Text('Last Week', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...lastWeek.map((notif) => NotificationItem(notification: notif)),
              const SizedBox(height: 24),
            ],
            if (lastMonth.isNotEmpty) ...[
              const Text('Last Month', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...lastMonth.map((notif) => NotificationItem(notification: notif)),
              const SizedBox(height: 24),
            ],
            if (lastYear.isNotEmpty) ...[
              const Text('Last Year', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...lastYear.map((notif) => NotificationItem(notification: notif)),
            ],
          ],
        ),
      ),
    );
  }
}
