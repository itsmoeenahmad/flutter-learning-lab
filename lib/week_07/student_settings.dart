import 'package:flutter/material.dart';

import 'secure_storage_service.dart';

/// Week 07: a small example of saving one value securely on the device.
class StudentSettingsPage extends StatefulWidget {
  const StudentSettingsPage({super.key});

  @override
  State<StudentSettingsPage> createState() => _StudentSettingsPageState();
}

class _StudentSettingsPageState extends State<StudentSettingsPage> {
  final _noteController = TextEditingController();
  final _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    // Read the previously saved value when this screen opens.
    debugPrint('Loading saved secure note.');
    _loadNote();
  }

  Future<void> _loadNote() async {
    final savedNote = await _storage.readNote();

    if (!mounted) {
      return;
    }
    setState(() => _noteController.text = savedNote);
    debugPrint('Saved note loaded.');
  }

  Future<void> _saveNote() async {
    debugPrint('Saving private note.');
    await _storage.saveNote(_noteController.text.trim());

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Note saved securely.')));
    debugPrint('Note saved securely.');
  }

  Future<void> _clearNote() async {
    debugPrint('Clearing saved private note.');
    await _storage.deleteNote();
    _noteController.clear();

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved note removed.')));
    debugPrint('Saved note cleared.');
  }

  @override
  void dispose() {
    // Dispose controllers when this page is removed from the widget tree.
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Secure Storage Demo')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Save a private note',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('The note is stored securely on this device.'),
          const SizedBox(height: 20),
          TextField(
            controller: _noteController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Private note',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _saveNote,
            icon: const Icon(Icons.lock_outline),
            label: const Text('Save securely'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _clearNote,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Clear saved note'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Use secure storage for passwords, tokens, and other sensitive values.',
          ),
        ],
      ),
    ),
  );
}
