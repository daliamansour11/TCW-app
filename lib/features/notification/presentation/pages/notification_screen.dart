import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:tcw/features/notification/presentation/widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    context.read<NotificationCubit>().fetchStudentPushNotification();
    Timer(Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });}

  Map<String, List<NotificationModel>> categorizeNotifications(
      List<NotificationModel> notifications) {
    final now = DateTime.now();
    final Map<String, List<NotificationModel>> categorized = {
      'Today': [],
      'Yesterday': [],
      'Last Week': [],
      'Last Month': [],
      'Last Year': [],
    };

    for (var notif in notifications) {
      final diff = now.difference(notif.createdAt);

      if (diff.inDays == 0) {
        categorized['Today']!.add(notif);
      } else if (diff.inDays == 1) {
        categorized['Yesterday']!.add(notif);
      } else if (diff.inDays <= 7) {
        categorized['Last Week']!.add(notif);
      } else if (diff.inDays <= 30) {
        categorized['Last Month']!.add(notif);
      } else {
        categorized['Last Year']!.add(notif);
      }
    }

    // Remove empty categories
    categorized.removeWhere((key, value) => value.isEmpty);
    return categorized;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              if (_isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Something went wrong or took too long.'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          context.read<NotificationCubit>()..fetchStudentPushNotification();
                          Timer(const Duration(seconds: 12), () {
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }            }
            if (state is NotificationError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            // Get notifications from loaded state or cubit's internal list
            final notifications = (state is NotificationLoaded)
                ? state.notifications
                : context.read<NotificationCubit>().allNotification;

            if (notifications.isEmpty) {
              return const Center(child: Text('No notifications found.'));
            }

            final categorized = categorizeNotifications(notifications);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categorized.entries
                    .map((entry) => [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...entry.value
                      .map((notif) => NotificationItem(notification: notif))
                      .toList(),
                  const SizedBox(height: 24),
                ])
                    .expand((widget) => widget)
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}