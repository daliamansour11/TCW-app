




import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';

import 'package:tcw/features/event/data/models/event_model.dart';

abstract class EventDataSource {
  Future<ApiResponse<EventModel>> getEvents();

  Future<ApiResponse<EventModel>> getEventDetails(int eventId);

}

class EventDataSourceImpl implements EventDataSource {
  @override
  @override
  Future<ApiResponse<EventModel>> getEvents() async {
    final response = await ApiService.instance.get('${ApiUrl.baseUrl}/meetings');

    if (response.isError) return response.error();

    try {
      final model = EventModel.fromJson(response.mapData);
      return response.copyWith(data: model);
    } catch (e) {
      return response.error();
    }
  }

  @override
  Future<ApiResponse<EventModel>> getEventDetails(int eventId)async {
    final response = await ApiService.instance.get(
      '${ApiUrl.events.getEventDetails}/$eventId',
    );

    if (response.isError) return response.error();

    final data = EventModel.fromJson(response.mapData['data']);

    return response.copyWith(data: data);
  }
  }