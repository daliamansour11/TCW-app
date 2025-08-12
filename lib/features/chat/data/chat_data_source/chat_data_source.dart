import 'package:dio/dio.dart';

import '../../../../core/apis/api_response.dart';
import '../../../../core/apis/api_service.dart';
import '../../../../core/apis/apis_url.dart';
import '../models/chat_response_model.dart';
import '../models/conversation_mssages_response.dart';


abstract class ChatDataSource{
  Future<ApiResponse<void>> sendMessage();
  Future<ApiResponse<InboxResponse>> getConversations();
  Future<ApiResponse<List<ChatMessage>>> getConversationMessages(int conversationId);

  }

class ChatDataSourceImp {
  // Send a message to a receiver
  Future<ApiResponse<void>> sendMessage({
    required String content,
    required int receiver_id,
  }) async {
    final formData = FormData.fromMap({
      'content': content,
      'receiver_id': receiver_id,
    });

    try {
      final response = await ApiService.instance.post(
        ApiUrl.chats.base,
        data: formData,
        withToken: true,
      );

      if (response.isError) {
        return response.copyWith<void>(
          data: null,
          message: response.message ?? 'Failed to send message',
        );
      }

      // Check if response indicates success
      if (response.mapData['status'] == 'success') {
        return response.copyWith<void>(data: null);
      } else {
        return response.copyWith<void>(
          data: null,
          message: 'Failed to send message',
        );
      }
    } catch (e) {
      return ApiResponse<void>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }


  Future<ApiResponse<InboxResponse>> getConversations() async {
    final response = await ApiService.instance.get(
      ApiUrl.chats.base,
      withToken: true,
    );

    if (response.isError) return response.error();

    final inboxResponse = InboxResponse.fromJson(response.mapData);

    return response.copyWith(data: inboxResponse);
  }


  Future<ApiResponse<List<ChatMessage>>> getConversationMessages(
      int conversationId) async {
    final response = await ApiService.instance.get(
      '${ApiUrl.chats.base}/$conversationId',
      withToken: true,
    );

    if (response.isError) return response.error();

    final rawList = response.mapData['data']?['data'];

    if (rawList == null || rawList.isEmpty) {
      return response.copyWith(data: []);
    }

    if (rawList is! List) {
      return response.copyWith(data: []);
    }

    final list = rawList.map((e) => ChatMessage.fromJson(e)).toList();

    return response.copyWith(data: list);
  }

}