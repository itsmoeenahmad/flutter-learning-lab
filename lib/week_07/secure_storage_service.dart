import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

/// Keeps the package code separate from the screen widget.
class SecureStorageService {
  // FlutterSecureStorage uses the device's protected storage area.
  final _storage = const FlutterSecureStorage();
  static const _noteKey = 'student_note';

  // read returns null when no value has been saved yet.
  Future<String> readNote() async {
    debugPrint('Reading note from secure storage.');
    return await _storage.read(key: _noteKey) ?? '';
  }

  Future<void> saveNote(String note) async {
    debugPrint('Writing note to secure storage.');
    await _storage.write(key: _noteKey, value: note);
  }

  Future<void> deleteNote() async {
    debugPrint('Deleting note from secure storage.');
    await _storage.delete(key: _noteKey);
  }
}
