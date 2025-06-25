import 'package:flutter/material.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class NonSubscribeEventItemWidget extends StatelessWidget {
  const NonSubscribeEventItemWidget({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(event.title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          Text(event.description,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 6,
                children: [
                  const Icon(Icons.calendar_month,
                      size: 16, color: Colors.grey),
                  Text(event.date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Row(
                spacing: 6,
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  Text(event.coachName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Row(
                spacing: 6,
                children: [
                  const Icon(Icons.access_time_filled, size: 16, color: Colors.grey),
                  Text(event.time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
