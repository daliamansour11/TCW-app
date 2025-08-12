part of '_chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}



class ConversationLoading extends ChatState {}


class ConversationsListLoaded extends ChatState {
  final InboxResponse conversations;
  ConversationsListLoaded(this.conversations);
}

class ConversationMessagesLoaded extends ChatState {
  final List<ChatMessage> messages;
  ConversationMessagesLoaded(this.messages);
}

class MessageSentLoaded extends ChatState {
  final List<Message> messages;
  MessageSentLoaded(this.messages);
}

class ConversationError extends ChatState {
  final String error;
  ConversationError(this.error);
}

