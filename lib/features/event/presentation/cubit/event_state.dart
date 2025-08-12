part of 'event_cubit.dart';

abstract class EventState  {
  const EventState();

}

class EventInitial extends EventState {}
class EventLoading extends EventState {}

class EventLoaded extends EventState {
  EventLoaded(this.event);

  final EventModel event;
}
class EventDetailsLoaded extends EventState {
  EventDetailsLoaded(this.event);

  final EventModel event ;


}class EventCommentLoaded extends EventState {
  final List<Comment> liveComments; // <-- new
  final bool isLoading;
  final String? error;

  EventCommentLoaded({
    this.liveComments = const [],
    this.isLoading = false,
    this.error,
  });

  EventState copyWith({
    List<Comment>? liveComments,
    bool? isLoading,
    String? error,
  }) {
    return EventCommentLoaded(
      liveComments: liveComments ?? this.liveComments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}


class EventError extends EventState {
  EventError(this.message);


  final String message;}


class GetEventLoaded extends EventState {
  GetEventLoaded({required this.event});
  final EventModel event ;
}