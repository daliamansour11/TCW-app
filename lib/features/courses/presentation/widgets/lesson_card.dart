import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/shared/shared_widget/custom_image.dart';
import '../../../../core/utils/asset_utils.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/models/lesson_model.dart';
import '../../data/models/student_course_details.dart';

class LessonCard extends StatefulWidget {
  const LessonCard({
    Key? key,
    required this.lesson,
    required this.index,
  }) : super(key: key);

  final LessonModel lesson;
  final int index;

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final videoUrl = widget.lesson.videoLinkPath ?? '';
    final thumbnailUrl = getYoutubeThumbnail(videoUrl);

    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.lessonScreen, arguments: widget.lesson);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImage(
                 thumbnailUrl,
                  height: 20. h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  radius: 20,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lesson ${widget.index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.lesson.durationMinutes ?? '0'} m",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Lesson content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lesson title
                  Text(
                    widget.lesson.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Task status
                  Row(
                    children: [
                      Icon(
                        widget.lesson.isCompleted == true
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        size: 18,
                        color: widget.lesson.isCompleted == true
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.lesson.isCompleted == true
                            ? 'Task Completed'
                            : 'Task Pending',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.lesson.isCompleted == true
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return AssetUtils.programPlaceHolder;
    final videoId = uri.queryParameters['v'] ??
        (uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null);
    if (videoId == null) return AssetUtils.programPlaceHolder;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
String formatDuration(int minutes) {
  if (minutes < 60) return '$minutes m';
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  return '${hours}h ${remainingMinutes}m';
}