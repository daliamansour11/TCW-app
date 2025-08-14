import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/apis/api_response.dart';
import '../../../../core/apis/api_service.dart';
import '../../../../core/apis/apis_url.dart';
import '../models/certificate_model.dart';
import '../models/course_details_model.dart';
import '../models/enrolled_course_model.dart';
import '../models/last_viewed_model.dart';
import '../models/lesson_model.dart';

import '../models/student_course_details.dart';
import '../models/wishlist_model.dart';

abstract class StudentCourseDatasources {
  Future<ApiResponse<List<EnrolledCourseModel>>> getEnrolledCourses(
  int limit,
  int offset,
  String? search,
);
  Future<ApiResponse<EnrolledCourseDetailsModel>> getStudentCourseDetails(int courseId);
  Future<ApiResponse<CertificateModel>> downloadCertificate(int courseId);
  Future<ApiResponse<bool>> updateLastViewed( int courseId,
      int sectionId,
      int lessonId,);
  Future<ApiResponse<LastViewedModel>> getLastViewed();
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId);
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId);
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
  Future<ApiResponse<EnrolledCourseDetailsModel>> getStudentCourseDetails(int courseId) async {
    final response = await ApiService.instance
        .get(ApiUrl.studentCourse.getCourseClassRoomDetails(courseId)
    ,withToken: true,
    );

    if (response.isError) return response.error();

    final course = EnrolledCourseDetailsModel.fromJson(response.mapData['data']);
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
      int courseId,
      int sectionId,
      int lessonId,) async {
    final formData = FormData.fromMap({
      'last_viewed_course': courseId ?? '',
      'last_viewed_section': sectionId,
      'last_viewed_lesson': lessonId,


    });

    final response = await ApiService.instance.post(
      ApiUrl.studentCourse.updateLastViewed,
      data:formData,
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

  @override
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId)async {
    try {
      final response = await ApiService.instance.post(
          '${ApiUrl.studentCourse.addCoursesToWishList(courseId)}',
          data: {},
          withToken: true
      );

      if (response.isError) {
        return response.copyWith<WishlistModel>(
          data: null,
          message: response.message ?? 'Failed to toggle like',
        );
      }

      try {
        final interactionResponse = WishlistModel.fromJson(
            response.mapData);
        return response.copyWith(data: interactionResponse);
      } catch (e) {
        return response.copyWith(
          data: null,
          message: 'Failed to parse response: ${e.toString()}',
        );
      }
    } catch (e) {
      return ApiResponse<WishlistModel>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }
}


