import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class EventDetailsNonSubscribedScreen extends StatefulWidget {
  const EventDetailsNonSubscribedScreen({super.key, required this.eventItem});

  final EventItem eventItem;

  @override
  State<EventDetailsNonSubscribedScreen> createState() =>
      _EventDetailsNonSubscribedScreenState();
}

class _EventDetailsNonSubscribedScreenState
    extends State<EventDetailsNonSubscribedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                child: CustomText(
                  widget.eventItem.title ?? '',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Row(
              children: [
                const Icon(Icons.date_range,
                    size: 14, color: AppColors.primaryColor),
                const SizedBox(width: 4),
                const CustomText(
                  'Monday, 4 Mar 2025',
                  fontSize: 12,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.person,
                    size: 14, color: AppColors.primaryColor),
                const SizedBox(width: 4),
                CustomText(
                  widget.eventItem.instructor?.name ?? '',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMetaInfo(),
                const SizedBox(height: 24),
                _buildAboutEventCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date + Instructor Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.date_range,
                size: 14, color: AppColors.primaryColor),
            const SizedBox(width: 4),
            const CustomText(
              'Monday, 4 Mar 2025', // Replace with real date if needed
              fontSize: 12,
            ),
            const SizedBox(width: 12),
            const Icon(Icons.person, size: 14, color: AppColors.primaryColor),
            const SizedBox(width: 4),
            CustomText(
              widget.eventItem.instructor?.name ?? '',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutEventCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLessonTag(),
          const SizedBox(height: 12),
          const Text(
            'About Event',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.eventItem.subTitle ??
                'No description available for this event.',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Lesson 6',
        style: TextStyle(fontSize: 12, color: Color(0xFFB58B00)),
      ),
    );
  }
}
