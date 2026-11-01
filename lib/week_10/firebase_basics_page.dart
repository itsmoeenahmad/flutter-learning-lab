import 'package:flutter/material.dart';

/// Week 10: a runnable cloud-data screen that uses safe local sample data.
/// Replace _loadTopics with the commented Firebase service after configuration.
class FirebaseBasicsPage extends StatefulWidget {
  const FirebaseBasicsPage({super.key});

  @override
  State<FirebaseBasicsPage> createState() => _FirebaseBasicsPageState();
}

class _FirebaseBasicsPageState extends State<FirebaseBasicsPage> {
  late Future<List<String>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _topicsFuture = _loadTopics();
  }

  Future<List<String>> _loadTopics() async {
    debugPrint('Loading Week 10 sample topics.');
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return ['Flutter Basics', 'Dart Practice', 'UI Design'];
  }

  void _reload() {
    setState(() => _topicsFuture = _loadTopics());
    debugPrint('Reloading sample topics.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Firebase Basics')),
    body: FutureBuilder<List<String>>(
      future: _topicsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final topics = snapshot.data ?? [];
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'This screen uses local sample data so it runs before Firebase setup.',
            ),
            const SizedBox(height: 8),
            const Text(
              'After flutterfire configure, use the commented code in firebase_setup_example.dart.',
            ),
            const SizedBox(height: 16),
            ...topics.map((topic) => Card(child: ListTile(title: Text(topic)))),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _reload,
              child: const Text('Reload Sample Data'),
            ),
          ],
        );
      },
    ),
  );
}
