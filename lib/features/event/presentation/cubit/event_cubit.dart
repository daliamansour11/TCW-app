import 'package:bloc/bloc.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:tcw/features/event/data/repositories/event_repository.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this._repository) : super(EventInitial());
  final EventRepositoryImp _repository;
  late EventModel events;

  Future<void> getEvents() async {
    emit(EventLoading());
    final result = await _repository.getEvents();

    if (result.isSuccess) {
      events = result.data!;
      emit(EventLoaded(events!));
    } else {
      emit(EventError(result.message ?? 'Failed to load event details'));
    }
  }

  Future<void> fetchCourseDetails(int eventId) async {
    emit(EventLoading());
    final result = await _repository.getEventDetails(eventId);

    if (result.isSuccess) {
      emit(EventDetailsLoaded(result.data!));
    } else {
      emit(EventError(result.message ?? 'Failed to load course details'));
    }
  }

}
