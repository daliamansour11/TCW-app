import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';

class CoursesViewmodel {
  CoursesViewmodel(this.ctx);
  final BuildContext ctx;
  final int limit = 20; // Default limit for fetching courses
  int page = 1; // Default page number for pagination
  final ScrollController scrollController = ScrollController();
  // Dispose all resources for any view use this viewmodel
  void dispose() {
    scrollController.removeListener(studentScrollListener);
    scrollController.dispose();
  }

  ///[StudentCourses] this part is only for student courses
  StudentCourseCubit get studentCubit => ctx.read<StudentCourseCubit>();
  Future fetchCourses() async {
    studentCubit.fetchEnrolledCourses(limit: limit, offset: page);
  }

  void studentScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        fetchCourses();
      }
    });
  }
}
