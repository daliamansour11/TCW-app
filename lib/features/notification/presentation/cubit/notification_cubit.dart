import 'package:bloc/bloc.dart';
import 'package:tcw/features/notification/data/data_scource/local_date_source/local_storage_service.dart';
import 'package:tcw/features/notification/data/models/notification_model.dart';
import 'package:tcw/features/notification/data/repositories/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(NotificationInitial());
  final NotificationRepositoryImp repository;

  List<NotificationModel> allNotification = [];
  final LocalStorageService _storageService = LocalStorageService();
  Future<void> fetchStudentPushNotification({bool loadMore = false}) async {
    if (loadMore) {
      emit(NotificationLoadingMore());
    } else {
      emit(NotificationLoading());
      allNotification.clear();
    }

    final result = await repository.getStudentPushNotification();

    if (result.isSuccess) {
      final readIds = await _storageService.getReadNotificationIds();
      final data = result.data ?? [];

      for (var notif in data) {
        notif.isRead = readIds.contains(notif.id);
      }

      if (loadMore) {
        allNotification.addAll(data);
      } else {
        allNotification = data;
      }

      emit(NotificationLoaded(allNotification));
    } else {
      emit(NotificationError(result.message ?? 'Failed to load notifications'));
    }
  }

  int get unreadCount => allNotification.where((n) => !(n.isRead ?? false)).length;
  void markAllAsRead() {
    for (var notification in allNotification) {
      notification.isRead = true;
    }
    emit(NotificationLoaded(List.from(allNotification)));
  }
  Future<void> markNotificationAsRead(NotificationModel notif) async {
    if (!notif.isRead) {
      notif.isRead = true;
      await _storageService.markNotificationAsReadLocally(notif.id);
      emit(NotificationLoaded(List.from(allNotification)));




    }
  }

}
