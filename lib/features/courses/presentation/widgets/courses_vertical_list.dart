import 'package:flutter/material.dart';


class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400, // Adjust height as needed
      // child: ListView.builder(
      //   itemCount: courses.length,
      //   itemBuilder: (context, index) =>
      //       VerticalCourseCard(course: courses[index]),
      // ),
    );
  }
}
