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
      onTap: ()=>  Zap.toNamed(AppRoutes.nonSubscribeEventDetailsScreen,
          arguments: event),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(event.title??'',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            Text('${event.subTitle??''}',
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 6,
                  children: [
                    const Icon(Icons.calendar_month,
                        size: 16, color: Colors.grey),
                    CustomText(
                      DateFormat('EEEE, d MMM yyyy').format(event.scheduledAt),
                      fontSize: 12,
                    ),
                  ],
                ),
                Row(
                  spacing: 6,
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    Text(event.instructor.name??'',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
            const    Row(
                  spacing: 6,
                  children: [
                   const  Icon(Icons.access_time_filled, size: 16, color: Colors.grey),
                    Text('02.oo - 03.30',
                        // event.time,
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
