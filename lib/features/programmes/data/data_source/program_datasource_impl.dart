import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart' hide LessonModel;
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/features/programmes/data/models/programme_model.dart';

abstract class ProgramDatasource {
  Future<ApiResponse<List<ProgramModel>>> getProgram({
    int limit,
    int offset,
    String? search,
    bool? latest,
    int? instructorId,
    int? categoryId,
    int? subCategoryId,
    bool? featured,
  });

  Future<ApiResponse<ProgramDetailModel>> getProgramDetails(int courseId);

  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit,
    int offset,
    bool subCategory,
  });
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId);

}
class ProgramDatasourceImpl implements ProgramDatasource {


  @override
  Future<ApiResponse<List<ProgramModel>>> getProgram({
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
    await ApiService.instance.get(
        '${ApiUrl.baseUrl}/course', queryParameters: query);

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => ProgramModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }


  @override
  Future<ApiResponse<ProgramDetailModel>> getProgramDetails(int courseId) async {
    final response = await ApiService.instance.get(
      ApiUrl.course.getCourseDetails(courseId),
    );

    if (response.isError) return response.error();

    try {
      final data = ProgramDetailModel.fromJson(response.mapData);
      return response.copyWith(data: data);
    } catch (e) {
      return response.error(message: 'Failed to parse program details: $e');
    }
  }


  @override
  Future<ApiResponse<List<LessonModel>>> getCourseLessons(int courseId) async {
    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getLesson(courseId),
    );

    if (response.isError) return response.error();

    final lesson = (response.mapData['data']['data'] as List)
        .map((e) => LessonModel.fromJson(e))
        .toList();
    return response.copyWith(data: lesson);
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

