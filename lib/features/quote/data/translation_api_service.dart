import 'dart:convert';

import 'package:http/http.dart' as http;

class TranslationApiService {
  Future<String> translateText(String text) async {
    final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=ru&dt=t&q=${Uri.encodeComponent(text)}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data[0][0][0] as String;
    } else {
      throw Exception("Translation is failed");
    }
  }
}