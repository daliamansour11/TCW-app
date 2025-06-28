import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';

class LessonCard extends StatelessWidget {
  // ignore: use_super_parameters
  const LessonCard({Key? key, required this.course}) : super(key: key);
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          AppRoutes.lessonScreen,
          // arguments: LessonModel(
          //   title: 'Understanding Concept Of React',
          //   author: 'Ramy Badr',
          //   date: DateTime(2025, 3, 9),
          //   videoUrl:
          //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          //   lessonTitle: 'React Hooks Basics',
          //   lessonDescription:
          //       'This lesson covers how to apply styles dynamically and conditionally to create modern and attractive user interfaces...',
          //   documentType: 'PDF',
          //   taskTitle: 'Collecting Moodboard from Dribbble.com',
          //   taskDescription:
          //       "Let's return to design thinking. Over time designers have built up their own body of approaches to solving classes of problems.",
          //   taskDeadline: '1 Day Left',
          // )
        );
      },
      child: CustomContainer(
        width: 80.w,
        color: Colors.white,
        borderRadius: 20,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImage(
                  course.thumb ?? '',
                  height: 20.h,
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
            ),
            Padding(
              padding: EdgeInsets.only(
                left: context.propWidth(12),
                right: context.propWidth(12),
                top: context.propHeight(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lap and duration row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5EEDC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Lap 1',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16, color: Colors.black54),
                          SizedBox(width: 4),
                          // TODO
                          // Text(course.duration,
                          //     style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.propHeight(8)),
                  Text(
                    course.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: context.propHeight(8)),
                  LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: Colors.grey.shade300,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: context.propHeight(12)),
                  const Row(
                    children: [
                      // TODO
                      // CircleAvatar(
                      //   radius: 18,
                      //   backgroundImage: AssetImage(course.coachImageUrl),
                      // ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TODO
                          // Text(
                          //   course.coachName,
                          //   style: const TextStyle(fontWeight: FontWeight.w600),
                          // ),
                          Text(
                            'Coach',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
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
}
