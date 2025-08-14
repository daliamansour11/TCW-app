import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchStudentPushNotification();

    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Map<String, List<NotificationModel>> categorizeNotifications(
      List<NotificationModel> notifications) {
    final now = DateTime.now();
    final Map<String, List<NotificationModel>> categorized = {
      tr('today'): [],
      tr('yesterday'): [],
      tr('last_week'): [],
      tr('last_month'): [],
      tr('last_year'): [],
    };

    for (var notif in notifications) {
      final diff = now.difference(notif.createdAt);

      if (diff.inDays == 0) {
        categorized[tr('today')]!.add(notif);
      } else if (diff.inDays == 1) {
        categorized[tr('yesterday')]!.add(notif);
      } else if (diff.inDays <= 7) {
        categorized[tr('last_week')]!.add(notif);
      } else if (diff.inDays <= 30) {
        categorized[tr('last_month')]!.add(notif);
      } else {
        categorized[tr('last_year')]!.add(notif);
      }
    }

    categorized.removeWhere((key, value) => value.isEmpty);
    return categorized;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: tr('notification')),
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
                      Text(tr('something_wrong')),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          context
                              .read<NotificationCubit>()
                              .fetchStudentPushNotification();
                          Timer(const Duration(seconds: 12), () {
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          });
                        },
                        child: Text(tr('retry')),
                      ),
                    ],
                  ),
                );
              }
            }

            if (state is NotificationError) {
              return Center(
                  child: Text(tr('error', args: [state.message])));
            }

            final notifications = (state is NotificationLoaded)
                ? state.notifications
                : context.read<NotificationCubit>().allNotification;

            if (notifications.isEmpty) {
              return Center(child: Text(tr('no_notifications')));
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
                      .map((notif) =>
                      NotificationItem(notification: notif))
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
