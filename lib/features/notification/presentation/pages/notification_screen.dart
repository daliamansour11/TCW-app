// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';
import 'package:tcw/features/notification/presentation/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<AppNotification> today = [
    AppNotification(
      title: "Resume Your Lesson!",
      subtitle: "Get back on track!",
      date: "10 March, 10:00 AM",
      icon: Icons.play_circle,
      iconBackground: Colors.brown.shade100,
    ),
    AppNotification(
      title: "Congratulations",
      subtitle: "You successfully completed this week's challenge.",
      date: "10 March, 12:00 AM",
      icon: Icons.check_circle,
      iconBackground: Colors.amber.shade100,
    ),
    AppNotification(
      title: "New Message!",
      subtitle: "Check your inbox now.",
      date: "10 March, 2:00 PM",
      icon: Icons.chat_bubble_outline,
      iconBackground: Colors.orange.shade100,
    ),
  ];

  final List<AppNotification> yesterday = [
    AppNotification(
      title: "Event Starting Soon!",
      subtitle: "Begins in 10 minutes. Don't miss out!",
      date: "9 March, 10:00 AM",
      icon: Icons.event,
      iconBackground: Colors.brown.shade100,
    ),
    AppNotification(
      title: "Live Now!",
      subtitle: "You successfully completed this week's challenge.",
      date: "10 March, 12:00 AM",
      icon: Icons.wifi_tethering,
      iconBackground: Colors.pink.shade100,
    ),
    AppNotification(
      title: "Live Session Ended!",
      subtitle: "You can still watch it here",
      date: "10 March, 2:00 PM",
      icon: Icons.stop_circle,
      iconBackground: Colors.brown.shade100,
    ),
  ];

  final List<AppNotification> lastWeek = [
    AppNotification(
      title: "Renew Your Subscription!",
      subtitle: "Subscription Expires On 10 March! Renew Now",
      date: "9 March, 10:00 AM",
      icon: Icons.refresh,
      iconBackground: Colors.brown.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 32),
          CustomAppBar(
            title: "Notifications",
          ),
          const Text("Today",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...today
              .map((notif) => NotificationItem(notification: notif))
              .toList(),
          const SizedBox(height: 24),
          const Text("Yesterday",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...yesterday
              .map((notif) => NotificationItem(notification: notif))
              .toList(),
          const SizedBox(height: 24),
          const Text("Last week",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...lastWeek
              .map((notif) => NotificationItem(notification: notif))
              .toList(),
        ]),
      ),
    );
  }
}
