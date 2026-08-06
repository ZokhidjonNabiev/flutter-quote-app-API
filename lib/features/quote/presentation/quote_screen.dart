import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/features/quote/presentation/quote_provider.dart';

class QuoteScreen extends ConsumerWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsyncValue = ref.watch(randomQuoteProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Random quotes"), centerTitle: true),
      body: Center(
        child: quoteAsyncValue.when(
          data: (quote) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                      child: Text("${quote.quote}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24))),
                ),

                SizedBox(height: 12),

                Text(
                  "${quote.author}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    ref.refresh(randomQuoteProvider);
                  },
                  child: Text("Get a quote"),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "The quote hasn't been downloaded: ${error}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    ref.refresh(randomQuoteProvider);
                  },
                  child: Text("Get a Quote"),
                ),
              ],
            );
          },

          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
