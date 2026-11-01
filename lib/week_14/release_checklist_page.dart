import 'package:flutter/material.dart';

/// Week 14: a small checklist for polishing and testing a project build.
class ReleaseChecklistPage extends StatefulWidget {
  const ReleaseChecklistPage({super.key});

  @override
  State<ReleaseChecklistPage> createState() => _ReleaseChecklistPageState();
}

class _ReleaseChecklistPageState extends State<ReleaseChecklistPage> {
  final List<_ReleaseCheck> _checks = [
    _ReleaseCheck('The app starts without errors'),
    _ReleaseCheck('The main feature works'),
    _ReleaseCheck('Required fields validate input'),
    _ReleaseCheck('Navigation returns correctly'),
    _ReleaseCheck('One expected error is handled'),
    _ReleaseCheck('No serious layout overflow appears'),
  ];

  int get _completedChecks => _checks.where((check) => check.isComplete).length;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Release Checklist')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('$_completedChecks of ${_checks.length} checks completed.'),
        const SizedBox(height: 12),
        ..._checks.map(
          (check) => Card(
            child: CheckboxListTile(
              title: Text(check.label),
              value: check.isComplete,
              onChanged: (value) {
                setState(() => check.isComplete = value ?? false);
                debugPrint(
                  'Release check: ${check.label} = ${check.isComplete}',
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Run flutter analyze and test the app on a device before building an APK.',
        ),
      ],
    ),
  );
}

class _ReleaseCheck {
  _ReleaseCheck(this.label);

  final String label;
  bool isComplete = false;
}
