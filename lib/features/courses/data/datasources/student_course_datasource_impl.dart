import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';
import 'package:tcw/features/courses/data/models/course_detail_model.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';

abstract class StudentCourseDatasources {
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(
      {int limit = 10, int offset = 1});
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId);
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId);
  Future<ApiResponse<bool>> updateLastViewed(LastViewedModel lastViewedData);
  Future<ApiResponse<LastViewedModel>> getLastViewed();
}

class StudentCourseDatasourceImpl implements StudentCourseDatasources {
  @override
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(
      {int limit = 10, int offset = 1}) async {
    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getCourses,
      queryParameters: {'limit': limit, 'offset': offset},
    );

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => EnrolledCourseModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }

  @override
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId) async {
    final response = await ApiService.instance
        .get(ApiUrl.studentCourse.getCourseDetails(courseId));

    if (response.isError) return response.error();

    final course = CourseDetailModel.fromJson(response.mapData['data']);
    return response.copyWith(data: course);
  }

  @override
  Future<ApiResponse<CertificateModel>> downloadCertificate(
      int courseId) async {
    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getCertificate(courseId),
    );

    if (response.isError) return response.error();

    final cert = CertificateModel.fromJson(response.mapData['data']);
    return response.copyWith(data: cert);
  }

  @override
  Future<ApiResponse<bool>> updateLastViewed(
      LastViewedModel lastViewedData) async {
    final response = await ApiService.instance.post(
      ApiUrl.studentCourse.updateLastViewed,
      data: lastViewedData.toJson(),
    );

    if (response.isError) return response.error();

    return response.copyWith(data: true);
  }

  @override
  Future<ApiResponse<LastViewedModel>> getLastViewed() async {
    final response =
        await ApiService.instance.get(ApiUrl.studentCourse.getLastViewed);

    if (response.isError) return response.error();

    final last = LastViewedModel.fromJson(response.mapData['data']);
    return response.copyWith(data: last);
  }
}
