import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/courses/data/datasources/course_datasource_impl.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';

import '../models/course_details_model.dart';
import '../models/wishlist_model.dart';

abstract class CourseRepository {
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

  Future<ApiResponse<CourseDetailsModel>> getCourseDetails(int courseId);

  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit,
    int offset,
    bool subCategory,
  });
  Future<ApiResponse<List<SectionModel>>> getCourseLessons(int courseId) ;
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId);
}

class CourseRepositoryImpl implements CourseRepository {
 const CourseRepositoryImpl(this._datasource);
  final CourseDatasourceImpl _datasource;


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
  }) {
    return _datasource.getCourses(
      limit: limit,
      offset: offset,
      search: search,
      latest: latest,
      instructorId: instructorId,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      featured: featured,
    );
  }

  @override
  Future<ApiResponse<CourseDetailsModel>> getCourseDetails(int courseId) {
    return _datasource.getCourseDetails(courseId);
  }

  @override
  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit = 10,
    int offset = 1,
    bool subCategory = false,
  }) {
    return _datasource.getCategories(limit: limit, offset: offset, subCategory: subCategory);
  }

 @override
 Future<ApiResponse<List<SectionModel>>> getCourseLessons(int courseId) {
   return _datasource.getCourseLessons(courseId);
 }

  @override
  Future<ApiResponse<WishlistModel>> toggleLikeOnCourses(int courseId) {
    return _datasource.toggleLikeOnCourses(courseId);

  }
 }