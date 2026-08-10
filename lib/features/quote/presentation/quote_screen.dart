import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/features/quote/data/quote_state.dart';
import 'package:quote_app/features/quote/presentation/quote_provider.dart';

class QuoteScreen extends ConsumerWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quoteNotifierProvider);
    final notifier = ref.read(quoteNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Random quotes"), centerTitle: true),
      body: Center(child: _buildBody(context, state, notifier)),
    );
  }

  Widget _buildBody(
    BuildContext context,
    QuoteState state,
    QuoteNotifier notifier,
  ) {
    if (state.isLoading) return const CircularProgressIndicator();

    if (state.error != null && state.quote == null) {
      return SizedBox(
        width: double.infinity,
        child: Text("Error: ${state.error}", textAlign: TextAlign.center),
      );
    }

    final quote = state.quote;

    if (quote == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("There any quotes", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20
          ),
          ),
          
          SizedBox(height: 24,),
          
          ElevatedButton(onPressed: (){
            notifier.fetchRandomQuote();
          },
              child: Text("Try again"))
        ],
      ) ;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              quote.quote,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: Text(
              quote.author,
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),

          if(state.translatedText != null) ...[
            Text(state.translatedText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blueGrey
            ),
            ),
            const SizedBox(height: 24,)
          ],

          ElevatedButton.icon(onPressed: state.isTranslating ? null : notifier.translateQuote,
              icon: state.isTranslating ?
              const SizedBox(width: 16, height: 16,
              child: CircularProgressIndicator(strokeWidth: 2,)
              ) : const Icon(Icons.translate),
              label: Text(state.isTranslating ? "Translating" : "Translate")
          ),

          const SizedBox(height: 12,),

          OutlinedButton.icon(onPressed: () => notifier.fetchRandomQuote(),
              icon: Icon(Icons.refresh),
              label: const Text("Get a Quote"))
        ],
      ),
    );
  }
}
