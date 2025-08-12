part of 'course_tasks_cubit.dart';

@immutable
sealed class CourseTasksState {}

final class CourseTasksInitial extends CourseTasksState {}
class CourseTasksLoading extends CourseTasksState {}

class CourseLoadingMore extends CourseTasksState {}


class CourseTasksLoaded extends CourseTasksState {
  CourseTasksLoaded(this.tasks, {this.hasMore = true});
  final List<Task> tasks;
  final bool hasMore;
}

class CourseTaskDetailsLoaded extends CourseTasksState {
  CourseTaskDetailsLoaded(this.course);
  final Task course;
}



class CourseTasksError extends CourseTasksState {
  CourseTasksError(this.message);
  final String message;
}