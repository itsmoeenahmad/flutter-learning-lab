import 'package:flutter/material.dart';

import 'study_task.dart';

/// A simple form that returns one new task to the previous screen.
class AddStudyTaskPage extends StatefulWidget {
  const AddStudyTaskPage({super.key});

  @override
  State<AddStudyTaskPage> createState() => _AddStudyTaskPageState();
}

class _AddStudyTaskPageState extends State<AddStudyTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();

  void _saveTask() {
    if (!_formKey.currentState!.validate()) {
      debugPrint('Study task form is invalid.');
      return;
    }

    final task = StudyTask(
      title: _titleController.text.trim(),
      subject: _subjectController.text.trim(),
    );
    debugPrint('New study task created: ${task.title}');
    Navigator.pop(context, task);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Study Task')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Task title'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter a task title.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(labelText: 'Subject'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter a subject.'
                : null,
          ),
          const SizedBox(height: 20),
          FilledButton(onPressed: _saveTask, child: const Text('Save Task')),
        ],
      ),
    ),
  );
}
