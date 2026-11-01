import 'package:flutter/material.dart';

import 'provider_counter_page.dart';

/// Week 08: a one-screen example of state handled with setState.
class StateBasicsPage extends StatefulWidget {
  const StateBasicsPage({super.key});

  @override
  State<StateBasicsPage> createState() => _StateBasicsPageState();
}

class _StateBasicsPageState extends State<StateBasicsPage> {
  int _count = 0;
  bool _isActive = false;

  void _increaseCount() {
    setState(() => _count++);
    debugPrint('setState counter increased: $_count');
  }

  void _reset() {
    setState(() {
      _count = 0;
      _isActive = false;
    });
    debugPrint('setState example reset.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('State Basics')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count: $_count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Active'),
              subtitle: Text(
                _isActive ? 'The setting is ON.' : 'The setting is OFF.',
              ),
              value: _isActive,
              onChanged: (value) {
                setState(() => _isActive = value);
                debugPrint('Active setting: $value');
              },
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _increaseCount,
              icon: const Icon(Icons.add),
              label: const Text('Increase Counter'),
            ),
            OutlinedButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const Text(
              'Provider is useful when more than one widget needs the same value.',
            ),
            TextButton(
              onPressed: () {
                debugPrint('Opening Provider counter example.');
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ProviderCounterPage(),
                  ),
                );
              },
              child: const Text('Open Provider Example'),
            ),
          ],
        ),
      ),
    ),
  );
}
