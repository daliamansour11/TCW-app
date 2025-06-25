import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';

class StudentCourseListWidget extends StatelessWidget {
  const StudentCourseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCourseCubit, StudentCourseState>(
      builder: (context, state) {
        if (state is StudentCourseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StudentCourseError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        }
        if (state is EnrolledCoursesLoaded) {
          final courses = state.courses;
          return const SizedBox(
            height: 400,
            // child: ListView.builder(
            //   itemCount: courses.length,
            //   itemBuilder: (context, index) =>
            //       VerticalCourseCard(course: courses[index]),
            // ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
