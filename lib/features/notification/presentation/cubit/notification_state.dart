part of 'notification_cubit.dart';

abstract class NotificationState  {
  const NotificationState();

 
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoadingMore extends NotificationState {}


class NotificationLoaded extends NotificationState {
  NotificationLoaded(this.notifications, {this.hasMore = true}); // FIXED: plural
  final List<NotificationModel> notifications;
  final bool hasMore;
}


class NotificationError extends NotificationState {
  NotificationError(this.message);
  final String message;
}