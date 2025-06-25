import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';

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

  Future<ApiResponse<CourseModel>> getCourseDetails(int courseId);

  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit,
    int offset,
    bool subCategory,
  });
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
        await ApiService.instance.get('/course', queryParameters: query);

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => CourseModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }

  @override
  Future<ApiResponse<CourseModel>> getCourseDetails(int courseId) async {
    final response = await ApiService.instance.get(
      '${ApiUrl.course.getCourseDetails}/$courseId',
    );

    if (response.isError) return response.error();

    final data = CourseModel.fromJson(response.mapData['data']);

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
}
