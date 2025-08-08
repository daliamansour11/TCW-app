part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}
class ChatGptInitial extends AiState {}

class ChatGptLoading extends AiState {}

class ChatGptSuccess extends AiState {
  final String response;
  ChatGptSuccess(this.response);
}

class ChatGptError extends AiState {
  final String message;
  ChatGptError(this.message);
}