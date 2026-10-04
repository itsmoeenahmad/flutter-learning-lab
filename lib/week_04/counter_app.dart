import 'package:flutter/material.dart';

/// Week 04: the starter counter app with a reset action.
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // This value changes when either button is pressed.
  int _counter = 0;

  // setState tells Flutter to build the screen again with the new value.
  void _increment() {
    setState(() => _counter++);
    debugPrint('Counter increased: $_counter');
  }

  void _reset() {
    setState(() => _counter = 0);
    debugPrint('Counter reset to 0.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Week 04 Counter App')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Button presses:'),
          // This reads the large text style from MaterialApp's theme.
          Text('$_counter', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset Counter'),
          ),
        ],
      ),
    ),
    // This button increases the counter.
    floatingActionButton: FloatingActionButton(
      onPressed: _increment,
      child: const Icon(Icons.add),
    ),
  );
}
