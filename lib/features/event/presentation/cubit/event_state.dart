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


}

class EventError extends EventState {
  EventError(this.message);


  final String message;}


class GetEventLoaded extends EventState {
  GetEventLoaded({required this.event});
  final EventModel event ;
}