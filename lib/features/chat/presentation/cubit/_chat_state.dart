part of '_chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}



class ConversationLoading extends ChatState {}

class ConversationLoaded extends ChatState {
  final List<InboxResponse> messages;
  ConversationLoaded(this.messages);
}class SendMessageLoaded extends ChatState {
  final List<Message> messages;
  SendMessageLoaded(this.messages);
}

class ConversationError extends ChatState {
  final String error;
  ConversationError(this.error);
}
