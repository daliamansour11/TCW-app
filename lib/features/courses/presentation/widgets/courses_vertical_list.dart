import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/course_vertical_card.dart';


class CourseListScreen extends StatelessWidget {
  final List<CourseModel> courses = [
    CourseModel(
      price: 100.0,
      available: 1,
      coachImageUrl: AssetManger.ex_1,
      title: 'Understanding Concept Of React',
      coachName: 'Amir Ali',
      coachRole: 'Instructor',
      duration: '2h 30m',
      imageUrl: AssetManger.container,
      lessons: 8,
      totalLessons: 8,
      watchedLessons: 6,
      date: DateTime(2025, 2, 25),
    ),
    CourseModel(
      available: 1,
      coachImageUrl: AssetManger.ex_1,
      title: 'Understanding Concept Of React',
      coachName: 'Amir Ali',
      coachRole: 'Instructor',
      duration: '2h 30m',
      imageUrl: AssetManger.ex_2,
      lessons: 8,
      totalLessons: 8,
      watchedLessons: 6,
      date: DateTime(2025, 2, 25),
      price: 100.0,
    ),
    CourseModel(
      available: 1,
      coachImageUrl: AssetManger.ex_2,
      title: 'Understanding Concept Of React',
      coachName: 'Amir Ali',
      coachRole: 'Instructor',
      duration: '2h 30m',
      imageUrl: AssetManger.ex_2,
      lessons: 8,
      totalLessons: 8,
      watchedLessons: 6,
      date: DateTime(2025, 2, 25),
      price: 100.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Adjust height as needed
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) =>
            VerticalCourseCard(course: courses[index]),
      ),
    );
  }
}
