import 'package:flutter/material.dart';

import 'task_validator.dart';

/// Week 13: validation and a simple manual testing checklist.
class ProjectQualityPage extends StatefulWidget {
  const ProjectQualityPage({super.key});

  @override
  State<ProjectQualityPage> createState() => _ProjectQualityPageState();
}

class _ProjectQualityPageState extends State<ProjectQualityPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final List<_CheckItem> _checks = [
    _CheckItem('App opens successfully'),
    _CheckItem('Main action works'),
    _CheckItem('Empty input shows a helpful message'),
    _CheckItem('Back navigation works'),
  ];

  void _testValidation() {
    if (!_formKey.currentState!.validate()) {
      debugPrint('Validation test failed as expected for empty input.');
      return;
    }
    debugPrint('Validation test passed.');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Valid task title.')));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Project Quality Check')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Validation example'),
        Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Task title'),
                  validator: TaskValidator.validateTitle,
                ),
              ),
              IconButton(
                onPressed: _testValidation,
                icon: const Icon(Icons.check_circle_outline),
                tooltip: 'Test validation',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Manual smoke-test checklist'),
        const SizedBox(height: 8),
        ..._checks.map(
          (item) => CheckboxListTile(
            title: Text(item.label),
            value: item.isComplete,
            onChanged: (value) {
              setState(() => item.isComplete = value ?? false);
              debugPrint('${item.label}: ${item.isComplete}');
            },
          ),
        ),
      ],
    ),
  );
}

class _CheckItem {
  _CheckItem(this.label);

  final String label;
  bool isComplete = false;
}
