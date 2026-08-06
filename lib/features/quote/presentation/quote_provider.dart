

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/features/quote/data/quote_api__service.dart';
import 'package:quote_app/features/quote/data/quote_model.dart';

final quoteApiServiceProvider = Provider<QuoteApiService>((ref) {
  return QuoteApiService();
});

final randomQuoteProvider = FutureProvider<QuoteModel>((ref) async {
  final apiService = ref.watch(quoteApiServiceProvider);
  return apiService.getRandomQuote();
});
