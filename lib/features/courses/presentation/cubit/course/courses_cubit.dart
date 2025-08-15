import 'package:bloc/bloc.dart';
import '../../../../programmes/data/models/program_detail_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/course_model.dart';
import '../../../data/models/section_model.dart';
import '../../../data/repositories/course_repository_impl.dart';

import '../../../../../core/apis/api_response.dart';
import '../../../data/models/course_detail_model.dart';
import '../../../data/models/wishlist_model.dart';

part 'courses_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this.repository) : super(CourseInitial());

  final CourseRepository repository;
  List<SectionModel> courseLessons = [];
  List<CourseModel> allCourses = [];
  List<LessonModel> favoriteLessons = [];

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

  Future<void> fetchCourseDetails(int? courseId) async {
    if (courseId == null || courseId <= 0) {
      emit(CourseError('Invalid course ID'));
      return;
    }

    print('📡 Fetching details for courseId: $courseId');
    emit(CourseLoading());

    final result = await repository.getCourseDetails(courseId);

    if (result.isSuccess && result.data != null) {
      emit(CourseDetailLoaded(result.data!));
    } else {
      print('❌ Failed: ${result.message}');
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
    // Cache old states for rollback
    final oldCourses = List<CourseModel>.from(allCourses);
    CourseDetailModel? oldDetail;
    if (state is CourseDetailLoaded) {
      oldDetail = (state as CourseDetailLoaded).course;
    }

    final listIndex = allCourses.indexWhere((c) => c.id == courseId);
    final currentListItem = listIndex != -1 ? allCourses[listIndex] : null;
    final currentDetailItem = oldDetail?.data;
    final newValue = !(currentListItem?.isWishlisted ?? currentDetailItem?.isWishlisted ?? false);

    // Optimistic update for list
    if (currentListItem != null) {
      allCourses[listIndex] = currentListItem.copyWith(isWishlisted: newValue);
    }
    // Optimistic update for detail
    if (currentDetailItem != null) {
      oldDetail = CourseDetailModel(
        status: oldDetail!.status,
        data: currentDetailItem.copyWith(isWishlisted: newValue),
      );
    }
    _emitSameTypeState(oldDetail);

    try {
      final response = await repository.toggleLikeOnCourses(courseId);

      if (response.data != null) {
        final finalValue = response.data!.isWishlisted;
        if (currentListItem != null) {
          allCourses[listIndex] = currentListItem.copyWith(isWishlisted: finalValue);
        }
        if (currentDetailItem != null) {
          oldDetail = CourseDetailModel(
            status: oldDetail!.status,
            data: currentDetailItem.copyWith(isWishlisted: finalValue),
          );
        }
        _emitSameTypeState(oldDetail);
      }
      return response;
    } catch (_) {
      // Rollback on error
      allCourses
        ..clear()
        ..addAll(oldCourses);
      if (oldDetail != null) {
        oldDetail = oldDetail;
      }
      _emitSameTypeState(oldDetail);
      return null;
    }
  }

  void _emitSameTypeState(CourseDetailModel? details) {
    if (state is CourseDetailLoaded && details != null) {
      emit(CourseDetailLoaded(details));
    } else if (state is CoursesLoaded) {
      emit(CoursesLoaded(List<CourseModel>.from(allCourses)));
    }
  }


  // Change your toggle function
  void toggleCourseWishlistLesson(LessonModel lesson) {
    if (favoriteLessons.contains(lesson)) {
      favoriteLessons.remove(lesson);
    } else {
      favoriteLessons.add(lesson);
    }
    emit(LessonWishlistUpdated(favoriteLessons));
  }




}