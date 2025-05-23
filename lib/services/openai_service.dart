import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final Uri _endpoint = Uri.parse('https://api.openai.com/v1/chat/completions');

  Future<String> sendMessage(String message) async {
    if (_apiKey.isEmpty) {
      return 'API key is missing. Please check your .env file.';
    }

    try {
      final response = await http.post(
        _endpoint,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        final error = jsonDecode(response.body);
        return 'Error ${response.statusCode}: ${error['error']['message'] ?? 'Unknown error'}';
      }
    } catch (e) {
      return 'Failed to connect to OpenAI: $e';
    }
  }
}