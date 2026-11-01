/// Keeps a small validation rule outside the screen so it can be tested.
class TaskValidator {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a task title.';
    }
    return null;
  }
}
