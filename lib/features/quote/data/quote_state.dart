
import 'package:quote_app/features/quote/data/quote_model.dart';

class QuoteState {
  final QuoteModel? quote;
  final String? translatedText;
  final bool isLoading;
  final bool isTranslating;
  final String? error;

  QuoteState({
    this.quote,
    this.translatedText,
    this.isLoading = false,
    this.isTranslating = false,
    this.error
});

  QuoteState copyWith({
    QuoteModel? quote,
    String? translatedText,
    bool? isLoading,
    bool? isTranslating,
    String? error,
}){
    return QuoteState(
      quote: quote ?? this.quote,
      translatedText: translatedText ?? this.translatedText,
      isLoading: isLoading ?? this.isLoading,
      isTranslating: isTranslating ?? this.isTranslating,
      error: error
    );
  }
}