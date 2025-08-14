import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/courses/data/datasources/student_course_datasource_impl.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';

import '../models/course_details_model.dart';
import '../models/student_course_details.dart';
import '../models/wishlist_model.dart';

abstract class StudentCourseRepository {
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses({
    int limit = 10,
    int offset = 1,
    String ? search,
  });
  Future<ApiResponse<EnrolledCourseDetailsModel>> getStudentCourseDetails(int courseId);
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId);
  Future<ApiResponse<bool>> updateLastViewed(  int courseId,
      int sectionId,
      int lessonId,);
  Future<ApiResponse<LastViewedModel>> getLastViewed();
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId) ;
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId) ;

  }

class StudentCourseRepositoryImpl implements StudentCourseRepository {
  StudentCourseRepositoryImpl();
  final StudentCourseDatasourceImpl studentCourseDatasourceImpl =
  StudentCourseDatasourceImpl();

  @override
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId) {
    return studentCourseDatasourceImpl.downloadCertificate(courseId);
  }

  @override
  Future<ApiResponse<EnrolledCourseDetailsModel>> getStudentCourseDetails(int courseId) {
    return studentCourseDatasourceImpl.getStudentCourseDetails(courseId);
  }

  @override
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses({
    int limit = 10,
    int offset = 1,
    String? search,
  }) async {
    return await studentCourseDatasourceImpl.getEnrolledCourses(
       limit, offset,search

    );
  }


  @override
  Future<ApiResponse<LastViewedModel>> getLastViewed() {
    return studentCourseDatasourceImpl.getLastViewed();
  }

  @override
  Future<ApiResponse<bool>> updateLastViewed(  int courseId,
       int sectionId,
       int lessonId,) {
    return studentCourseDatasourceImpl.updateLastViewed(courseId,sectionId,lessonId);
  }

  @override
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId) {
    return studentCourseDatasourceImpl.getCourseLessons(courseId);
  }

  @override
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId) {
    return studentCourseDatasourceImpl.toggleLikeOnCourses(courseId);

  }
}
