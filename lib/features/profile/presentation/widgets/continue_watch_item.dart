import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/features/profile/data/model/video_item.dart';

class ContinueWatchingItem extends StatelessWidget {
  final VideoItem video;

  const ContinueWatchingItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with play indicator
          Stack(
            alignment: Alignment.center,
            children: [
              // Video thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  video.thumbnailUrl,
                  width: 160,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),

              // Play button
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              // Progress bar at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: video.isCompleted ? 1.0 : 0.3,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Video title
          Text(
            video.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Duration/status
          Row(
            children: [
              if (video.isTaskPending)
                const Icon(Icons.access_time, size: 14, color: Colors.grey),

              Text(
                video.isTaskPending ? tr('task_pending') : video.duration,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
