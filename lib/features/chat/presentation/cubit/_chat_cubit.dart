import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/chat_repo/chat_repositories.dart';
import '../../data/models/chat_response_model.dart';
import '../../data/models/conversation_mssages_response.dart';
import '../../data/models/message_model.dart';

part '_chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositoriesImp _repositoriesImp;

  ChatCubit(this._repositoriesImp) : super(ChatInitial());



  Future<void> fetchConversationList() async {
    emit(ConversationLoading());
    try {
      final res =
      await _repositoriesImp.getConversations();
      if (res.isError || res.data == null) {
        emit(ConversationError(res.message ?? 'Failed to fetch messages'));
        return;
      }
      emit(ConversationsListLoaded(res.data!));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }



  Future<void> fetchConversationMessages(int conversationId) async {
    emit(ConversationLoading());
    try {
      final res = await _repositoriesImp.getConversationMessages(conversationId);
      if (res.isError || res.data == null) {
        emit(ConversationError(res.message ?? 'Failed to fetch messages'));
        return;
      }

      final messages = res.data!;

      emit(ConversationMessagesLoaded(messages));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }


  Future<void> sendMessage(int receiverId, String content) async {
    try {
      final res = await _repositoriesImp.sendMessage(content, receiverId);

      if (res.isError) {
        emit(ConversationError(res.message ?? 'Failed to send message'));
        return;
      }

      if (state is MessageSentLoaded) {
        final current =
        List<Message>.from((state as MessageSentLoaded).messages);

        final newMessage = Message(

          time: _getCurrentTime(),
          isMe: true,
          avatarUrl: null, name: '', email: '', message: content,
        );

        current.add(newMessage);

        emit(MessageSentLoaded(current));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }
}
