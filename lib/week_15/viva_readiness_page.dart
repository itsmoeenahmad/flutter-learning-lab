import 'package:flutter/material.dart';

/// Week 15: a small checklist for a clear final project demonstration.
class VivaReadinessPage extends StatefulWidget {
  const VivaReadinessPage({super.key});

  @override
  State<VivaReadinessPage> createState() => _VivaReadinessPageState();
}

class _VivaReadinessPageState extends State<VivaReadinessPage> {
  final List<_VivaItem> _items = [
    _VivaItem('I can explain the problem and target users.'),
    _VivaItem('I can demonstrate the main user flow.'),
    _VivaItem('I can explain where the app stores or fetches data.'),
    _VivaItem('I can explain my personal contribution.'),
    _VivaItem('I know one current limitation of the project.'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Viva Readiness')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Use this list before the final project demonstration.'),
        const SizedBox(height: 12),
        ..._items.map(
          (item) => CheckboxListTile(
            title: Text(item.label),
            value: item.isReady,
            onChanged: (value) {
              setState(() => item.isReady = value ?? false);
              debugPrint('Viva readiness: ${item.label} = ${item.isReady}');
            },
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Keep the demo simple: problem, main action, result, and your technical choices.',
        ),
      ],
    ),
  );
}

class _VivaItem {
  _VivaItem(this.label);

  final String label;
  bool isReady = false;
}
