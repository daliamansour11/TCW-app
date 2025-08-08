import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tcw/features/ai/data/ai_services.dart';

part 'ai_state.dart';
class AiCubit extends Cubit<AiState> {
  final AiService aiService;
  DateTime? _lastRequestTime;

  AiCubit(this.aiService) : super(AiInitial());

  Future<void> askChatGpt(String prompt) async {
    if (_lastRequestTime != null &&
        DateTime.now().difference(_lastRequestTime!) < const Duration(seconds: 2)) {
      emit(ChatGptError("Please wait before sending another request"));
      return;
    }

    _lastRequestTime = DateTime.now();
    emit(ChatGptLoading());

    try {
      final response = await aiService.sendMessage(prompt);
      emit(ChatGptSuccess(response));
    } catch (e) {
      emit(ChatGptError("حدث خطأ: ${e.toString()}"));
    }
  }
}
