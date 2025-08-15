import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';

import '../models/course_detail_model.dart';
import '../models/wishlist_model.dart';

abstract class CourseDatasource {
  Future<ApiResponse<List<CourseModel>>> getCourses({
    int limit,
    int offset,
    String? search,
    bool? latest,
    int? instructorId,
    int? categoryId,
    int? subCategoryId,
    bool? featured,
  });

  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId);

  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit,
    int offset,
    bool subCategory,
  });
  Future<ApiResponse<List<SectionModel>>> getCourseLessons(int courseId);
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId) ;
}

class CourseDatasourceImpl implements CourseDatasource {
  @override
  Future<ApiResponse<List<CourseModel>>> getCourses({
    int limit = 10,
    int offset = 1,
    String? search,
    bool? latest,
    int? instructorId,
    int? categoryId,
    int? subCategoryId,
    bool? featured,
  }) async {
    final query = {
      'limit': limit,
      'offset': offset,
      if (search != null) 'search': search,
      if (latest == true) 'latest': 1,
      if (instructorId != null) 'instructor_id': instructorId,
      if (categoryId != null) 'category_id': categoryId,
      if (subCategoryId != null) 'sub_category_id': subCategoryId,
      if (featured == true) 'featured': 1,
    };

    final response =
        await ApiService.instance.get('${ApiUrl.baseUrl}/course',
            queryParameters: query);

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => CourseModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }

  @override
  Future<ApiResponse<CourseDetailModel>> getCourseDetails(int courseId) async {
    final response = await ApiService.instance.get(
      '${ApiUrl.course.getCourseDetails}/$courseId',
    );

    if (response.isError) return response.error();

    final data = CourseDetailModel.fromJson(response.mapData['data']);

    return response.copyWith(data: data);
  }

  @override
  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit = 10,
    int offset = 1,
    bool subCategory = false,
  }) async {
    final query = {
      'limit': limit,
      'offset': offset,
      'sub_category': subCategory,
    };

    final response = await ApiService.instance.get(
      ApiUrl.course.getCategories,
      queryParameters: query,
    );

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }
  @override
  Future<ApiResponse<List<SectionModel>>> getCourseLessons(int courseId) async{
    final response = await ApiService.instance.get(ApiUrl.studentCourse.getLesson(courseId),
    );

    if (response.isError) return response.error();

    final lesson = (response.mapData['data']['data'] as List)
        .map((e) => SectionModel.fromJson(e))
        .toList();
    return response.copyWith(data: lesson);

  }
  @override
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId)async {
    try {
      final response = await ApiService.instance.post(
          '${ApiUrl.course.addCoursesToWishList(courseId)}',
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
