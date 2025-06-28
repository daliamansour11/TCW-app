part of 'courses_cubit.dart';


abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoadingMore extends CourseState {}


class CoursesLoaded extends CourseState {
  CoursesLoaded(this.courses, {this.hasMore = true});
  final List<CourseModel> courses;
  final bool hasMore;
}

class CourseDetailLoaded extends CourseState {
  CourseDetailLoaded(this.course);
  final CourseModel course;
}

class CategoriesLoaded extends CourseState {
  CategoriesLoaded(this.categories);
  final List<CategoryModel> categories;
}

class CourseError extends CourseState {
  CourseError(this.message);
  final String message;
}