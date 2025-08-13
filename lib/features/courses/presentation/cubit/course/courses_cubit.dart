import 'package:bloc/bloc.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';
import 'package:tcw/features/courses/data/repositories/course_repository_impl.dart';

import '../../../../../core/apis/api_response.dart';
import '../../../data/models/course_details_model.dart';
import '../../../data/models/wishlist_model.dart';

part 'courses_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this.repository) : super(CourseInitial());

  final CourseRepository repository;
  List<SectionModel> courseLessons = [];
   List<CourseModel> allCourses = [];
  Future<void> fetchCourses({
    int limit = 10,
    int offset = 1,
    String? search,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      emit(CourseLoadingMore());
    } else {
      emit(CourseLoading());
      allCourses.clear();
    }
    final result = await repository.getCourses(
      limit: limit,
      offset: offset,
      search: search,
    );

    if (result.isSuccess) {
      if (loadMore) {
        allCourses.addAll(result.data ?? []);
      } else {
        allCourses = result.data ?? [];
      } emit(CoursesLoaded(
        allCourses,
        hasMore: (result.data?.length ?? 0) == limit,
      ));
    } else {
      emit(CourseError(result.message ?? 'Failed to load courses'));
    }
  }
   List<CourseModel> allRecommnadCourses = [];
  Future<void> fetchRecommendedCourses({
    int limit = 10,
    int offset = 1,
    String? search,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      emit(CourseLoadingMore());
    } else {
      emit(CourseLoading());
      allCourses.clear();
    }
    final result = await repository.getCourses(
      limit: limit,
      offset: offset,
      search: search,
    );

    if (result.isSuccess) {
      if (loadMore) {
        allCourses.addAll(result.data ?? []);
      } else {
        allCourses = result.data ?? [];
      } emit(CoursesLoaded(
        allCourses,
        hasMore: (result.data?.length ?? 0) == limit,
      ));
    } else {
      emit(CourseError(result.message ?? 'Failed to load courses'));
    }
  }


  Future<void> fetchCourseDetails(int courseId) async {
    emit(CourseLoading());
    final result = await repository.getCourseDetails(courseId);

    if (result.isSuccess && result.data != null) {
      emit(CourseDetailLoaded(result.data!));
    } else {
      emit(CourseError(result.message ?? 'Failed to load program details'));
    }
  }

  Future<void> fetchCategories({
    int limit = 10,
    int offset = 1,
    bool subCategory = false,
  }) async {
    emit(CourseLoading());
    final result = await repository.getCategories(
      limit: limit,
      offset: offset,
      subCategory: subCategory,
    );

    if (result.isSuccess) {
      emit(CategoriesLoaded(result.data!));
    } else {
      emit(CourseError(result.message ?? 'Failed to load categories'));
    }
  }

  Future<void> getCourseLessons(int courseId) async {
    emit(CourseLoading());
    final result = await repository.getCourseLessons(courseId);

    if (result.isSuccess) {
      courseLessons = result.data??[];
      emit(CourseLessonsLoaded(courseLessons));
    } else {
      emit(CourseError(result.message ?? 'Failed to load course details'));
    }
  }
  List<CourseModel> favoriteCourses = [];
  Future<ApiResponse<WishlistModel>?> toggleCourseWishlist(int courseId) async {
    emit(CourseLoading());

    try {
      final response = await repository.toggleLikeOnCourses(courseId);
      if (response.data != null) {
        final updatedWishlisted = response.data!.isWishlisted;

        final index = allCourses.indexWhere((c) => c.id == courseId);
        if (index != -1) {
          final updatedCourse = allCourses[index].copyWith(isWishlisted: updatedWishlisted);
          final updatedCourses = List<CourseModel>.from(allCourses);
          updatedCourses[index] = updatedCourse;
          allCourses = updatedCourses;
          emit(CoursesLoaded(updatedCourses));
        } else {
          emit(CourseError('Course not found'));
        }
      } else {
        emit(CourseError(response.message ?? 'Failed to toggle wishlist'));
      }
      return response;
    } catch (e) {
      emit(CourseError('Error: ${e.toString()}'));
      return null;
    }
  }


}


