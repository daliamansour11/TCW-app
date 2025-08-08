import 'package:bloc/bloc.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';
import 'package:tcw/features/courses/data/repositories/course_repository_impl.dart';

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

    if (result.isSuccess) {
      emit(CourseDetailLoaded(result.data!));
    } else {
      emit(CourseError(result.message ?? 'Failed to load course details'));
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
}


