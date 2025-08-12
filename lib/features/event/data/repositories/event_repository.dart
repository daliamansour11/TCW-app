

import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/event/data/data_source/event_data_source.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

abstract  class EventRepository{
   Future<ApiResponse<EventModel>>getEvents();
   Future<ApiResponse<EventModel>>getEventDetails(int eventId);
   Future<ApiResponse<Comment>> addCommentInLive({required int liveId,required String body});

   }

class EventRepositoryImp extends EventRepository{
  EventRepositoryImp(this._dataSource);


 final  EventDataSource _dataSource;
  @override
  Future<ApiResponse<EventModel>> getEvents()async {
   return await _dataSource.getEvents();
  }

  @override
  Future<ApiResponse<EventModel>> getEventDetails(int eventId) async{
    return await _dataSource.getEventDetails(eventId);

  }
  @override
  Future<ApiResponse<Comment>> addCommentInLive({required int liveId,required String body})async {
    return await _dataSource.addCommentInLive( liveId: liveId, body: body);

}}