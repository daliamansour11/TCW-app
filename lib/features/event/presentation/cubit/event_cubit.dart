import 'package:bloc/bloc.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:tcw/features/event/data/repositories/event_repository.dart';

import '../../data/models/live_model_details.dart';

part 'event_state.dart';
class EventCubit extends Cubit<EventState> {
  EventCubit(this._repository) : super(EventInitial());
  final EventRepositoryImp _repository;
  EventModel? events;

  Future<void> getEvents() async {
    emit(EventLoading());
    final result = await _repository.getEvents();

    if (result.isSuccess && result.data != null) {
      events = result.data!;
      emit(EventLoaded(events!));
    } else {
      emit(EventError(result.message ?? 'Failed to load event'));
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
  Future<void> addCommentInLive({
    required int liveId,
    required String body,
  }) async {
    emit(EventLoading());
    final result = await _repository.addCommentInLive(liveId: liveId, body: body);

    if (result.isSuccess && result.data != null) {
      final newComment = result.data!;
      List<Comment> updatedComments = [];

      if (state is EventCommentLoaded) {
        updatedComments = List.from((state as EventCommentLoaded).liveComments)
          ..add(newComment);
      } else {
        updatedComments = [newComment];
      }

      emit(EventCommentLoaded(liveComments: updatedComments));

    } else {
      emit(EventError(result.message ?? 'Failed to add comment'));
    }
  }


  Future<void> loadMoreEvents() async {
    if (events?.links.next == null) return;
    emit(EventLoading());
    // : events!.links.next!
    final result = await _repository.getEvents();

    if (result.isSuccess && result.data != null) {
      try {
        final newEventModel = EventModel.fromJson(result.data as Map<String, dynamic>);
        final mergedMeetings = [...events!.data, ...newEventModel.data];
        events = EventModel(
          data: mergedMeetings,
          links: newEventModel.links,
          meta: newEventModel.meta,
        );
        emit(EventLoaded(events!));
      } catch (e) {
        emit(EventError('Parsing error: $e'));
      }
    } else {
      emit(EventError(result.message ?? 'Failed to load event'));
    }
  }

}
