import 'package:flutter/material.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/vertical_course_card.dart';


class CourseListScreen extends StatelessWidget {
   const CourseListScreen({super.key, required this.courses, });
final List<EnrolledCourseModel>courses;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 400, // Adjust height as needed
      child:  ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final course = courses[index];
          return VerticalCourseCard(course: course);
        },
      )
    );
  }
}
