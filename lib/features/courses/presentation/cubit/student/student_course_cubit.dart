import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/courses/data/repositories/student_course_repository_impl.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';

part 'student_course_state.dart';
class StudentCourseCubit extends Cubit<StudentCourseState> {
  StudentCourseCubit(this.repository) : super(StudentCourseInitial());

  final StudentCourseRepository repository;

  List<EnrolledCourseModel> enrolledCourses = [];

  Future<void> fetchEnrolledCourses({
    int limit = 10,
    int offset = 1,
    String? search,
  }) async {
    emit(StudentCourseLoading());
    final result = await repository.getEnrolledCourses(
      limit: limit,
      offset: offset,
      search: search

    );

    print('Fetched courses: ${result.data?.length ?? 0}');

    if (result.isSuccess && result.data != null) {
      final newCourses = result.data!;
      if (offset == 1) {
        enrolledCourses = [];
      }

      enrolledCourses.addAll(newCourses);

      emit(EnrolledCoursesLoaded(List.from(enrolledCourses)));
    } else {
      emit(StudentCourseError(result.message ?? 'Failed to load courses'));
    }
  }
    Future<void> getLastViewed() async {

    final result = await repository.getLastViewed();
    if (result.isSuccess) {

      emit(LastViewedLoaded(result.data!));
    } else {
      emit(StudentCourseError(result.message ?? 'Failed to load courses'));
    }
  }
  Future<void> updateLastViewed(LastViewedModel model) async {
    final response = await repository.updateLastViewed(model);
  }

  Future<void> downloadCertificate(int courseId) async {
    emit(StudentCourseLoading());
    final result = await repository.downloadCertificate(courseId);
    if (result.isSuccess) {
      emit(CertificateLoaded(result.data!));
    } else {
      emit(StudentCourseError(
          result.message ?? 'Failed to download certificate'));
    }
  }
  Future<void> getCourseLessons(int courseId) async {
    emit(StudentCourseLoading());
    final result = await repository.getCourseLessons(courseId);

    if (result.isSuccess) {
    emit(CourseLessonsLoaded(result.data!));
    } else {
    emit(StudentCourseError(result.message ?? 'Failed to load course details'));
    }
  }
}
