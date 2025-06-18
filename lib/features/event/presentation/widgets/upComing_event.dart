import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class UpComingEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onToggleAlert;

  const UpComingEventCard(
      {super.key, required this.event, required this.onToggleAlert});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Date + Time + Zoom + Alert Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.date,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(event.time,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          const SizedBox(width: 8),
                          Icon(Icons.videocam, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("Zoom",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: onToggleAlert,
                    icon: Icon(
                      event.isAlertSet
                          ? Icons.notifications_off
                          : Icons.notifications,
                      size: 16,
                    ),
                    label:
                        Text(event.isAlertSet ? "Cancel Alert" : "Get Alert",
                            style: const TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          event.isAlertSet ? Colors.white : AppColors.primaryColor,
                      backgroundColor:
                          event.isAlertSet ? AppColors.primaryColor : Colors.transparent,
                      elevation: 0,
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),

              /// Title
              Text(event.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),

              /// Description
              Text(
                event.description,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 16),

              /// Coach Info
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/1.jpg"),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.coachName,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(event.coachRole,
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: context.propHeight(16)),
      ],
    );
  }
}
