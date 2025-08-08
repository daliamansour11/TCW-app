import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {

  final openAiApiKey = dotenv.env['OPENAI_API_KEY'];  late final Dio _dio;

  AiService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer $openAiApiKey',
        'Content-Type': 'application/json',
      },
    ));
  }

  Future<String> sendMessage(String prompt) async {
    final response = await _dio.post('/chat/completions', data: {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
    });

    if (response.statusCode == 200) {
      final content = response.data['choices'][0]['message']['content'];
      return content;
    } else {
      throw Exception('Failed to get response from ChatGPT');
    }
  }
}
