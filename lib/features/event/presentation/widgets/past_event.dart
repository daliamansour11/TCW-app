import 'package:flutter/material.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class PastEventCard extends StatelessWidget {
  final Event event;

  const PastEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(event.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
      
          const SizedBox(height: 8),
      
          /// Description
          Text(event.description, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      
          const SizedBox(height: 16),
      
          /// Date + Speaker + Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(event.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
              Row(children: [
                Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(event.coachName, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
              Row(children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(event.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
