part of 'student_course_cubit.dart';


abstract class StudentCourseState {}

class StudentCourseInitial extends StudentCourseState {}

class StudentCourseLoading extends StudentCourseState {}

class StudentCourseLoadingMore extends StudentCourseState {}


class EnrolledCoursesLoaded extends StudentCourseState {
  EnrolledCoursesLoaded(this.courses);
  final List<EnrolledCourseModel> courses;
}

class LastViewedLoaded extends StudentCourseState {
  LastViewedLoaded(this.lastViewed);
  final LastViewedModel lastViewed;
}

class CertificateLoaded extends StudentCourseState {
  CertificateLoaded(this.certificate);
  final CertificateModel certificate;
}

class StudentCourseError extends StudentCourseState {
  StudentCourseError(this.message);

  final String message;

}
class CourseLessonsLoaded extends StudentCourseState {
  CourseLessonsLoaded(this.lesson);

  final List<LessonModel> lesson;
}
class StudentCourseDetailsLoaded extends StudentCourseState {
  StudentCourseDetailsLoaded(this.enrolledCourseDetails);
  final EnrolledCourseDetailsModel enrolledCourseDetails ;
}