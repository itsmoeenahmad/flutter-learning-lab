import 'package:flutter/material.dart';

import 'add_study_task_page.dart';
import 'study_task.dart';

/// Week 12: an MVP template with one complete add-and-view user flow.
class StudyPlannerPage extends StatefulWidget {
  const StudyPlannerPage({super.key});

  @override
  State<StudyPlannerPage> createState() => _StudyPlannerPageState();
}

class _StudyPlannerPageState extends State<StudyPlannerPage> {
  final List<StudyTask> _tasks = [];

  Future<void> _openAddTask() async {
    final task = await Navigator.of(context).push<StudyTask>(
      MaterialPageRoute<StudyTask>(builder: (_) => const AddStudyTaskPage()),
    );

    if (task == null || !mounted) {
      return;
    }

    setState(() => _tasks.add(task));
    debugPrint('Study task saved to the local list.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Study Planner Template')),
    body: _tasks.isEmpty
        ? const Center(child: Text('No study tasks yet. Add your first task.'))
        : ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.menu_book_outlined),
                  title: Text(task.title),
                  subtitle: Text(task.subject),
                ),
              );
            },
          ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: _openAddTask,
      icon: const Icon(Icons.add),
      label: const Text('Add Task'),
    ),
  );
}
