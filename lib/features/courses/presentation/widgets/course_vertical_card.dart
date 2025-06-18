// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/routes/routes_names.dart';

class VerticalCourseCard extends StatelessWidget {
  final CourseModel course;

  const VerticalCourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('d/M/yyyy').format(course.date ?? DateTime.now());

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
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Instructor + Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Image.asset(course.coachImageUrl).image,
                          radius: 12,
                        ),
                        SizedBox(width: context.propWidth(8)),
                        Text(course.coachName),
                      ],
                    ),
                    Text(formattedDate),
                  ],
                ),
                const SizedBox(height: 12),
      
                /// Title
                Text(
                  course.title,
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
                    Text(
                      '${course.watchedLessons} / ${course.totalLessons} Watched',
                      style: const TextStyle(
                        color:  const Color(0xFF175941),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                        child: const Text(
                          'SHOW LESSONS',
                          style: TextStyle(
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
