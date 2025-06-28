import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/data/repositories/student_course_repository_impl.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';

part 'student_course_state.dart';

class StudentCourseCubit extends Cubit<StudentCourseState> {
  StudentCourseCubit(this.repository) : super(StudentCourseInitial());

  final StudentCourseRepository repository;

  Future<void> fetchEnrolledCourses({required int limit,required int offset}) async {
    emit(offset==1?StudentCourseLoading(): StudentCourseLoadingMore());
    final result = await repository.getEnrolledCourses(limit:limit ,offset:offset );
    if (result.isSuccess) {
      emit(EnrolledCoursesLoaded(result.data!));
    } else {
      emit(StudentCourseError(result.message ?? 'Failed to load courses'));
    }
  }

  Future<void> fetchLastViewed() async {
    emit(StudentCourseLoading());
    final result = await repository.getLastViewed();
    if (result.isSuccess) {
      emit(LastViewedLoaded(result.data!));
    } else {
      emit(StudentCourseError(
          result.message ?? 'Failed to load last viewed data'));
    }
  }

  Future<void> updateLastViewed(LastViewedModel model) async {
    await repository.updateLastViewed(model);
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
}
