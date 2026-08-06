import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_app/features/quote/data/quote_model.dart';

class QuoteApiService {
  static const String _baseURL = 'https://dummyjson.com/quotes/random';
  Future<QuoteModel> getRandomQuote() async{
    final response = await http.get(Uri.parse(_baseURL));

    if(response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return QuoteModel.fromJson(data);
    } else {
      throw Exception("Error in downloading ${response.statusCode}");
    }
  }
}