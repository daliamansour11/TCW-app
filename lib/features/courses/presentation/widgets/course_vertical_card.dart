

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/constansts/context_extensions.dart';
import '../../data/models/course_model.dart';
import '../../../../core/routes/app_routes.dart';

class VerticalCourseCard extends StatelessWidget {

  const VerticalCourseCard({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    // final formattedDate =
    //     DateFormat('d/M/yyyy').format(course.date ?? DateTime.now());

    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.courseDetailsScreen);
      },
      child: Column(
        children: [
          Container(
            //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha:0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Instructor + Date Row
                // TODO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundImage:
                        //       Image.asset(course.coachImageUrl).image,
                        //   radius: 12,
                        // ),
                        SizedBox(width: context.propWidth(8)),
                        Text(course.instructorName??''),
                      ],
                    ),
                    // Text(formattedDate),
                  ],
                ),

                const SizedBox(height: 12),

                /// Title
                Text(
                  course.title ?? '',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                /// Watched Progress + Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TODO
                    // Text(
                    //   tr('watched_progress', args: ['${course.watchedLessons}', '${course.totalLessons}']),
                    //   style: const TextStyle(
                    //     color: Color(0xFF175941),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),

                    Container(
                      height: 15,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0x33B7924F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Center(
                        child: Text(
                          tr('show_lessons'),
                          style: const TextStyle(
                            color: Color(0xFFB7924F),
                            fontSize: 10,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: context.propHeight(25)),
        ],
      ),
    );
  }
}
