import 'package:flutter/material.dart';

// Each week keeps its example in a separate folder.
import 'week_04/counter_app.dart';
import 'week_05/profile_dashboard.dart';
import 'week_06/course_catalog.dart';
import 'week_07/student_settings.dart';

// main.dart only starts the app and opens the weekly examples.
void main() {
  debugPrint('Flutter Learning Lab started.');
  runApp(const FlutterLearningApp());
}

/// The root widget opens the list of weekly examples.
class FlutterLearningApp extends StatelessWidget {
  const FlutterLearningApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Learning Lab',
    debugShowCheckedModeBanner: false,
    // Set the common colors and text styles once for the whole app.
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const LearningHomePage(),
  );
}

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Each item contains the page that should open when it is tapped.
    const lessons = [
      _Lesson(
        'Week 04',
        'Counter app and state',
        Icons.add_circle_outline,
        CounterApp(),
      ),
      _Lesson(
        'Week 05',
        'Widgets and layouts',
        Icons.dashboard_outlined,
        ProfileDashboard(),
      ),
      _Lesson(
        'Week 06',
        'Forms and navigation',
        Icons.route_outlined,
        CourseCatalogPage(),
      ),
      _Lesson(
        'Week 07',
        'Packages and local storage',
        Icons.settings_outlined,
        StudentSettingsPage(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Lab'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: lessons.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(lesson.icon)),
              title: Text(lesson.week),
              subtitle: Text(lesson.topic),
              trailing: const Icon(Icons.chevron_right),
              // Navigator pushes the selected week on top of this page.
              onTap: () {
                debugPrint('Opening ${lesson.week}: ${lesson.topic}');
                Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (_) => lesson.page));
              },
            ),
          );
        },
      ),
    );
  }
}

class _Lesson {
  const _Lesson(this.week, this.topic, this.icon, this.page);

  // Simple data used to build one card on the home screen.
  final String week;
  final String topic;
  final IconData icon;
  final Widget page;
}
