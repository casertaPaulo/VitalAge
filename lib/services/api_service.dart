// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class IAService extends ChangeNotifier {
  String resposta = "Aguarde enquanto sua resposta está sendo gerada...";
  Future<void> completeChat(String message) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    const MODEL = 'gpt-3.5-turbo';
    const URL = 'https://api.openai.com/v1/chat/completions';

    var response = await http.post(
      Uri.parse(URL),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': MODEL,
        'messages': [
          {'role': 'user', 'content': message},
        ],
        'temperature': 0.7,
        'max_tokens': 500,
      }),
    );

    final data = json.decode(utf8.decode(response.bodyBytes));

    if (data.containsKey('choices') &&
        data['choices'] is List &&
        data['choices'].isNotEmpty) {
      final chatResponse = data['choices'][0]['message']['content'];
      resposta = chatResponse;
    } else {
      resposta = "Vazia ou invalida";
    }
    notifyListeners();
  }
}
