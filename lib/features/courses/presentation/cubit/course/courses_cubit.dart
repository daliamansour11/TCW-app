import 'package:bloc/bloc.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/repositories/course_repository_impl.dart';

part 'courses_state.dart';


class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this.repository) : super(CourseInitial());

  final CourseRepository repository;

  Future<void> fetchCourses({
    int limit = 10,
    int offset = 1,
    String? search,
    bool? latest,
    int? instructorId,
    int? categoryId,
    int? subCategoryId,
    bool? featured,
  }) async {
    emit(CourseLoading());
    final result = await repository.getCourses(
      limit: limit,
      offset: offset,
      search: search,
      latest: latest,
      instructorId: instructorId,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      featured: featured,
    );

    if (result.isSuccess) {
      emit(CoursesLoaded(result.data!));
    } else {
      emit(CourseError(result.message?? 'Failed to load courses'));
    }
  }

  Future<void> fetchCourseDetails(int courseId) async {
    emit(CourseLoading());
    final result = await repository.getCourseDetails(courseId);

    if (result.isSuccess) {
      emit(CourseDetailLoaded(result.data!));
    } else {
      emit(CourseError(result.message?? 'Failed to load course details'));
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
      emit(CourseError(result.message?? 'Failed to load categories'));
    }
  }
}
