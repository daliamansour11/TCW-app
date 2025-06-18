import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/lesson_card.dart';
class CourseListHorizontal extends StatelessWidget {
  final List<CourseModel> courses;

  const CourseListHorizontal({Key? key, required this.courses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.propHeight(320), // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return SizedBox(
            width: context.propWidth(260), // Adjust width as needed
            child: LessonCard(course: courses[index]),
          );
        },
      ),
    );
  }
}
