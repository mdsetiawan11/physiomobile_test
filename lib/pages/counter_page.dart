import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${counterProvider.counter}',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (counterProvider.errorMessage != null)
              Text(
                counterProvider.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Decrement Button
            ElevatedButton.icon(
              onPressed: counterProvider.decrement,
              icon: const Icon(Icons.remove, color: Colors.white),
              label: const Text('Less', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(100, 50),
              ),
            ),

            // Reset Button
            OutlinedButton.icon(
              onPressed: counterProvider.reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
            ),

            // Increment Button
            ElevatedButton.icon(
              onPressed: counterProvider.increment,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(100, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
