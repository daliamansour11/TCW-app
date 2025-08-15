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
  final CourseDetailModel course;
}

class CategoriesLoaded extends CourseState {
  CategoriesLoaded(this.categories);
  final List<CategoryModel> categories;
}


class CourseError extends CourseState {
  CourseError(this.message);
  final String message;
}
class UpdateLastViewedSuccess extends CourseState{
  UpdateLastViewedSuccess();

}

class UpdateLastViewedError  extends CourseState{
  UpdateLastViewedError(this.message);
  final String message;
}
class CourseLessonsLoaded extends CourseState {
  CourseLessonsLoaded(this.lesson);
  final List<SectionModel> lesson;
}class LessonWishlistUpdated extends CourseState {
  LessonWishlistUpdated(this.lesson);
  final List<LessonModel> lesson;
}
