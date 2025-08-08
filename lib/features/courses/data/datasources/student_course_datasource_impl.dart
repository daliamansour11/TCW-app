import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/certificate_model.dart';
import 'package:tcw/features/courses/data/models/course_detail_model.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';

abstract class StudentCourseDatasources {
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(
  int limit,
  int offset,
  String? search,
);
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId);
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId);
  Future<ApiResponse<bool>> updateLastViewed(LastViewedModel lastViewedData);
  Future<ApiResponse<LastViewedModel>> getLastViewed();
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId);
}

class StudentCourseDatasourceImpl implements StudentCourseDatasources {
  @override
  @override
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(int limit, int offset, String? search) async {
    final query = {
      'limit': limit,
      'offset': offset,
      if (search != null) 'search': search,
    };

    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getCourses,
      withToken: true,
      queryParameters: query,
    );

    if (response.isError) return response.error();

    final rawList = response.mapData['data']?['data'];
    if (rawList is! List) return response.copyWith(data: []);

    final list = rawList.map((e) => EnrolledCourseModel.fromJson(e)).toList();

    return response.copyWith(data: list);
  }


    @override
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId) async {
    final response = await ApiService.instance
        .get(ApiUrl.studentCourse.getCourseClassRoomDetails(courseId)
    ,withToken: true,
    );

    if (response.isError) return response.error();

    final course = CourseDetailModel.fromJson(response.mapData['data']);
    return response.copyWith(data: course);
  }

  @override
  Future<ApiResponse<CertificateModel>> downloadCertificate(
      int courseId) async {
    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getCertificate(courseId),
      withToken: true,

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
      withToken: true,
    );

    if (response.isError) return response.error();

    return response.copyWith(data: true);
  }

  @override
  Future<ApiResponse<LastViewedModel>> getLastViewed() async {
    final response =
        await ApiService.instance.get(ApiUrl.studentCourse.getLastViewed,
          withToken: true,);

    if (response.isError) return response.error();

    final last = LastViewedModel.fromJson(response.mapData['data']);
    return response.copyWith(data: last);
  }

  @override
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId) async{
    final response = await ApiService.instance.get(ApiUrl.studentCourse.getLesson(courseId),
      withToken: true,
    );

    if (response.isError) return response.error();

    final lesson = (response.mapData['data']['data'] as List)
        .map((e) => LessonModel.fromJson(e))
        .toList();
    return response.copyWith(data: lesson);

  }
  }

