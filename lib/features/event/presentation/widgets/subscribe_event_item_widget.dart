import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class SubscribeEventItemWidget extends StatelessWidget {
  const SubscribeEventItemWidget({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      padding: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          _buildEventCover(),
          _buildLabelAndDuration(),
          CustomText(
            event.title,
            maxLines: 2,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          _buildProgressBar(),
          _buildCoachInfo(),
        ],
      ),
    );
  }

  Widget _buildEventCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CustomImage(event.cover, fit: BoxFit.cover),
      ),
    );
  }
  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: 0.4,
      backgroundColor: Colors.grey[300],
      color: AppColors.primaryColor,
      minHeight: 5,
      borderRadius: BorderRadius.circular(4),
    );
  }

  Widget _buildLabelAndDuration() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomContainer(
          fullPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          borderRadius: 20,
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          child: const CustomText(
            'Lap 3',
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.access_time,
                size: 14, color: AppColors.primaryColor),
            const SizedBox(width: 4),
            CustomText(
              event.time,
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoachInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 14,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(event.coachName, fontSize: 13),
            const CustomText('Coach', fontSize: 11, color: Colors.grey),
          ],
        )
      ],
    );
  }
}
