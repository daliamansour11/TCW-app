
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';

abstract class TaskDataSource
{
  Future<ApiResponse<List<Task>>> getCourseTasks(int courseId);
  Future<ApiResponse<Task>> getCourseTaskDetails(int taskId);

}

class TaskDataSourceImp extends TaskDataSource {


  @override
  @override
  Future<ApiResponse<List<Task>>> getCourseTasks(int courseId) async {
    final response = await ApiService.instance.get(
      ApiUrl.studentCourse.getCourseTasks,
      queryParameters: {
        'course_id': courseId,
      },
    );

    if (response.isError) return response.error();

    final List<Task> tasks = (response.mapData['data']['data'] as List)
        .map((e) => Task.fromJson(e))
        .toList();

    return response.copyWith(data: tasks);
  }

  @override
  Future<ApiResponse<Task>> getCourseTaskDetails(int taskId) async {
    final response = await ApiService.instance.get
      (ApiUrl.studentCourse.getCourseTasksDetails(taskId),
    );
    if (response.isError) return response.error();

    final task = Task.fromJson(response.mapData['data']['data']);
    return response.copyWith(data: task);
  }
}

