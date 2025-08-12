import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/features/tasks/data/repositories/course_task_repositories.dart';

part 'course_tasks_state.dart';

class CourseTasksCubit extends Cubit<CourseTasksState> {
  CourseTasksCubit(this._repository) : super(CourseTasksInitial());

 final CourseTaskRepositoriesImp _repository;
  List<Task> allTasks = [];

  Future<void> getCourseTasks(int courseId) async {
    emit(CourseTasksLoading());
    allTasks.clear();

    final result = await _repository.getCourseTasks(courseId);
    if (result.isSuccess) {
      allTasks = result.data ?? [];
      emit(CourseTasksLoaded(allTasks));
    } else {
      emit(CourseTasksError(result.message ?? 'Error loading tasks'));
    }
  }
   Future<void> fetchCourseTaskDetails(int taskId) async {
     emit(CourseTasksLoading());
     final result = await _repository.getCourseTaskDetails(taskId);

     if (result.isSuccess) {
       emit(CourseTaskDetailsLoaded(result.data!));
     } else {
       emit(CourseTasksError(result.message ?? 'Failed to load course details'));
     }
   }

 }

