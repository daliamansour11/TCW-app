import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/lesson_model.dart' hide LessonModel;
import '../../../data/repositories/student_course_repository_impl.dart';
import '../../../data/models/enrolled_course_model.dart';
import '../../../data/models/last_viewed_model.dart';
import '../../../data/models/certificate_model.dart';

import '../../../../../core/utils/asset_utils.dart';
import '../../../../programmes/data/models/program_detail_model.dart';
import '../../../data/models/student_course_details.dart';

part 'student_course_state.dart';
class StudentCourseCubit extends Cubit<StudentCourseState> {
  StudentCourseCubit(this.repository) : super(StudentCourseInitial());

  final StudentCourseRepository repository;

  List<EnrolledCourseModel> enrolledCourses = [];
bool isEmpty= false;

  Future<void> fetchEnrolledCourses({
    int limit = 10,
    int offset = 1,
    String? search,
  }) async {
    emit(StudentCourseLoading());

    final result = await repository.getEnrolledCourses(
      limit: limit,
      offset: offset,
      search: search,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    List<EnrolledCourseModel> newCourses = result.data ?? [];


    if (offset == 1) {
      enrolledCourses = [];
    }
    enrolledCourses.addAll(newCourses);

    emit(EnrolledCoursesLoaded(List.from(enrolledCourses)));
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
Future<void> getEnrolledCourseDetails(int courseId) async {
  emit(StudentCourseLoading());
  final result = await repository.getEnrolledCourseDetails(courseId);

  if (result.isSuccess && result.data != null) {
    emit(StudentCourseDetailsLoaded(result.data! as EnrolledCourseModel));
  } else {
    emit(StudentCourseError(result.message ?? 'Failed to load program details'));
  }
}


}
