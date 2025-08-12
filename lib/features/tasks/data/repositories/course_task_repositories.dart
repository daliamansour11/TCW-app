
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/features/tasks/data/data_source/task_data_source_imp.dart';

abstract class CourseTaskRepositories {

  Future<ApiResponse<List<Task>>> getCourseTasks(int courseId) ;
  Future<ApiResponse<Task>> getCourseTaskDetails(int taskId);

}

class CourseTaskRepositoriesImp extends CourseTaskRepositories{
  CourseTaskRepositoriesImp(this._dataSource);

  final TaskDataSource _dataSource;
  @override
  Future<ApiResponse<List<Task>>> getCourseTasks(int courseId)async {

    return await _dataSource.getCourseTasks(courseId);

  }

  @override
  Future<ApiResponse<Task>> getCourseTaskDetails(int taskId) async{
    return await  _dataSource.getCourseTaskDetails(taskId);

  }

}