import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/courses/data/datasources/student_course_datasource_impl.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';
import 'package:tcw/features/courses/data/models/course_detail_model.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';

abstract class StudentCourseRepository {
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses({
    int limit = 10,
    int offset = 1,
  });
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId);
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId);
  Future<ApiResponse<bool>> updateLastViewed(LastViewedModel lastViewedData);
  Future<ApiResponse<LastViewedModel>> getLastViewed();
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
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId) {
    return studentCourseDatasourceImpl.getCourseDetails(courseId);
  }

  @override
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(
      {int limit = 10, int offset = 1}) {
    return studentCourseDatasourceImpl.getEnrolledCourses(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<ApiResponse<LastViewedModel>> getLastViewed() {
    return studentCourseDatasourceImpl.getLastViewed();
  }

  @override
  Future<ApiResponse<bool>> updateLastViewed(LastViewedModel lastViewedData) {
    return studentCourseDatasourceImpl.updateLastViewed(lastViewedData);
  }
}
