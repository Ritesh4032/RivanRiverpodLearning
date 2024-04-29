import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_rierpod/Providers/counter_provider.dart';

class MyCounterPage extends ConsumerWidget {
  const MyCounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have clicked the button for this times'),
            SizedBox(
              height: 20,
            ),
            Text(
              counter.toString(),
              style: const TextStyle(color: Colors.blue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).decreament();
                  },
                  child: const Icon(Icons.remove)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increament();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
