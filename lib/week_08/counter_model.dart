import 'package:flutter/foundation.dart';

/// Holds a value that can be shared by more than one widget.
class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increase() {
    _count++;
    debugPrint('Provider counter increased: $_count');
    notifyListeners();
  }

  void reset() {
    _count = 0;
    debugPrint('Provider counter reset.');
    notifyListeners();
  }
}
