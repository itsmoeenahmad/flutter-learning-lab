import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_model.dart';

/// A small Provider example for values shared by multiple widgets.
class ProviderCounterPage extends StatelessWidget {
  const ProviderCounterPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => CounterModel(),
    child: Scaffold(
      appBar: AppBar(title: const Text('Provider Counter')),
      body: const _ProviderCounterBody(),
    ),
  );
}

class _ProviderCounterBody extends StatelessWidget {
  const _ProviderCounterBody();

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Both widgets read the same CounterModel value.'),
          const SizedBox(height: 12),
          Text(
            '${counter.count}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 12),
          const _CounterMessage(),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => context.read<CounterModel>().increase(),
            child: const Text('Increase'),
          ),
          OutlinedButton(
            onPressed: () => context.read<CounterModel>().reset(),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _CounterMessage extends StatelessWidget {
  const _CounterMessage();

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterModel>().count;
    return Text('The shared counter is $count.');
  }
}
