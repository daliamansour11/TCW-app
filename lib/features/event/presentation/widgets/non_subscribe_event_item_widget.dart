import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:zapx/zapx.dart';

import '../../../../core/shared/shared_widget/custom_text.dart';

class NonSubscribeEventItemWidget extends StatelessWidget {
  const NonSubscribeEventItemWidget({super.key, required this.event});
  final Meeting event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Zap.toNamed(
        AppRoutes.nonSubscribeEventDetailsScreen,
        arguments: event,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event title
            Text(
              event.title ?? tr('event_title'),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 4),

            // Event subtitle
            Text(
              event.subTitle ?? tr('no_description'),
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Event meta info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    CustomText(
                      DateFormat.yMMMMEEEEd(context.locale.toString())
                          .format(event.scheduledAt),
                      fontSize: 12,
                    ),
                  ],
                ),

                // Instructor
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.instructor.name ?? tr('unknown_instructor'),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                // Time
                const  Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      // event.startTime != null && event.endTime != null
                      //     ? '${event.startTime} - ${event.endTime}'
                      //     :
                    '02:00 - 03:30',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
