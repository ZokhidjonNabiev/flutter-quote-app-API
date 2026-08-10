

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/features/quote/data/quote_api__service.dart';
import 'package:quote_app/features/quote/data/quote_model.dart';
import 'package:quote_app/features/quote/data/quote_state.dart';
import 'package:quote_app/features/quote/data/translation_api_service.dart';

final quoteApiServiceProvider = Provider<QuoteApiService>((ref) {
  return QuoteApiService();
});

final translationApiServiceProvider = Provider<TranslationApiService>((ref) => TranslationApiService());


class QuoteNotifier extends Notifier<QuoteState>{
  @override
  QuoteState build() {
    Future.microtask(() => fetchRandomQuote()) ;
    return QuoteState(isLoading: true);
  }

  Future<void> fetchRandomQuote() async{
    state = state.copyWith(isLoading: true, error: null, translatedText: null);

    try {
      final apiService = ref.read(quoteApiServiceProvider);
      final newQuote = await apiService.getRandomQuote();


      state = state.copyWith(isLoading: false, quote: newQuote);
    } catch(e){
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> translateQuote() async{
    if(state.quote == null || state.isTranslating == true) return;

    state = state.copyWith(isTranslating: true);

    try{
      final translationService = ref.read(translationApiServiceProvider);
      final translation = await translationService.translateText(state.quote!.quote);

      state = state.copyWith(translatedText: translation, isTranslating: false);
    } catch(e){
      state = state.copyWith(isTranslating: false, error: "Error in translating ${e.toString()}");
    }
  }

}

final quoteNotifierProvider = NotifierProvider<QuoteNotifier, QuoteState>(() => QuoteNotifier());