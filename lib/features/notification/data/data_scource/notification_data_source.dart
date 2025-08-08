



import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';

abstract class NotificationDataSource {
  Future<ApiResponse<List<NotificationModel>>> getStudentPushNotification();




}

class NotificationDataSourceImpl implements NotificationDataSource {

  @override
  Future<ApiResponse<List<NotificationModel>>> getStudentPushNotification()async {
  final response = await ApiService.instance.get(
  ApiUrl.notification.base,
  withToken: true,
  queryParameters: {
  'receiver_type': 'student',

  },
  );

    if (response.isError) return response.error();

    final list = (response.mapData['data']['data'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();

    return response.copyWith(data: list);
  }

}