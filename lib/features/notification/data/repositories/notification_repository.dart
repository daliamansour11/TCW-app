import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/notification/data/data_scource/notification_data_source.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<ApiResponse<List<NotificationModel>>> getStudentPushNotification();




}
class NotificationRepositoryImp extends NotificationRepository{
  NotificationRepositoryImp(this._dataSource);

 final NotificationDataSourceImpl _dataSource;
@override
  Future<ApiResponse<List<NotificationModel>>> getStudentPushNotification()async {
    return  await _dataSource.getStudentPushNotification();

}
}