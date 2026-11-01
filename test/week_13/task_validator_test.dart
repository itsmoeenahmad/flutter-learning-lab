import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlearning/week_13/task_validator.dart';

void main() {
  test('rejects an empty task title', () {
    expect(TaskValidator.validateTitle(''), 'Enter a task title.');
  });

  test('accepts a task title', () {
    expect(TaskValidator.validateTitle('Review Flutter notes'), isNull);
  });
}
