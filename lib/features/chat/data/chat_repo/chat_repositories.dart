import '../../../../core/apis/api_response.dart';
import '../chat_data_source/chat_data_source.dart';
import '../models/chat_response_model.dart';
import '../models/conversation_mssages_response.dart';

abstract class ChatRepositories {
  Future<ApiResponse<void>> sendMessage(String content, int receiver_id);

  Future<ApiResponse<InboxResponse>> getConversations();

  Future<ApiResponse<List<ChatMessage>>> getConversationMessages(
      int conversationId);
}


class  ChatRepositoriesImp extends  ChatRepositories{

 final ChatDataSourceImp _dataSourceImp;

  ChatRepositoriesImp(this._dataSourceImp);

  @override
  Future<ApiResponse<List<ChatMessage>>> getConversationMessages(int conversationId)async {
   return await _dataSourceImp.getConversationMessages(conversationId);
  }

  @override
  Future<ApiResponse<InboxResponse>> getConversations()async {
    return await _dataSourceImp.getConversations();

  }

  @override
  Future<ApiResponse<void>> sendMessage(String content, int receiver_id) async {
    return await _dataSourceImp.sendMessage(content: content, receiver_id: receiver_id);

  }

}