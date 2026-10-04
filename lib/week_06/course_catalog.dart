import 'package:flutter/material.dart';

/// Week 06: lists, forms, dialogs, navigation, and responsive layout.
class CourseCatalogPage extends StatelessWidget {
  const CourseCatalogPage({super.key});

  // Local data keeps this example focused on the user interface.
  static const courses = [
    Course('CS-314', 'Mobile App Development', 'Flutter and Dart', 3),
    Course('CS-321', 'Database Systems', 'SQL and data modelling', 3),
    Course('CS-331', 'Software Engineering', 'Design and testing', 3),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Course Catalog'),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            debugPrint('Back button pressed. Returning to the learning home.');
            Navigator.pop(context);
          },
        ),
      ],
    ),
    drawer: const _CatalogDrawer(),
    // LayoutBuilder tells us how much width this widget can use.
    body: LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 700;

        if (isWideScreen) {
          // A GridView is more suitable when there is enough horizontal space.
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.4,
            ),
            itemBuilder: (context, index) => _CourseCard(courses[index]),
          );
        }

        // A ListView is easier to read on a narrow phone screen.
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: courses.length,
          itemBuilder: (context, index) => _CourseCard(courses[index]),
        );
      },
    ),
  );
}

class Course {
  const Course(this.code, this.title, this.description, this.creditHours);

  final String code;
  final String title;
  final String description;
  final int creditHours;
}

class _CourseCard extends StatelessWidget {
  const _CourseCard(this.course);

  final Course course;

  @override
  Widget build(BuildContext context) => Card(
    // Stack allows the credit-hours badge to sit over the card.
    child: Stack(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(course.title),
          subtitle: Text(course.description),
          // Send the selected course to the next screen.
          onTap: () async {
            debugPrint('Opening course: ${course.code}');
            final message = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                builder: (_) => CourseDetailsPage(course: course),
              ),
            );

            if (!context.mounted || message == null) {
              return;
            }
            debugPrint(message);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Chip(label: Text('${course.creditHours} CH')),
        ),
      ],
    ),
  );
}

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(course.code)),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(course.description),
          const SizedBox(height: 8),
          Text('${course.creditHours} credit hours'),
          const Spacer(),
          FilledButton(
            // The registration page returns a success message with pop.
            onPressed: () async {
              debugPrint('Opening registration form for ${course.code}.');
              final message = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (_) => RegistrationPage(course: course),
                ),
              );

              if (!context.mounted || message == null) {
                return;
              }
              Navigator.pop(context, message);
            },
            child: const Text('Register'),
          ),
          TextButton(
            // A bottom sheet presents extra actions from the bottom.
            onPressed: () {
              debugPrint('Opening course actions bottom sheet.');
              showModalBottomSheet<void>(
                context: context,
                builder: (_) => const _CourseActions(),
              );
            },
            child: const Text('View actions'),
          ),
        ],
      ),
    ),
  );
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.course});

  final Course course;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rollNumberController = TextEditingController();

  Future<void> _submit() async {
    // validate runs every TextFormField validator in this Form.
    if (!_formKey.currentState!.validate()) {
      debugPrint('Registration form is invalid.');
      return;
    }

    debugPrint('Registration form is valid.');

    final confirmed = await showDialog<bool>(
      context: context,
      // A dialog asks for confirmation before finishing registration.
      builder: (context) => AlertDialog(
        title: const Text('Confirm registration'),
        content: Text('Register for ${widget.course.code}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (mounted && confirmed == true) {
      debugPrint('Registered for ${widget.course.code}.');
      Navigator.pop(context, 'Registered for ${widget.course.code}.');
    }
  }

  @override
  void dispose() {
    // Controllers should be disposed when a stateful screen closes.
    _nameController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registration Form')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Student name'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter your name.'
                : null,
          ),
          TextFormField(
            controller: _rollNumberController,
            decoration: const InputDecoration(labelText: 'Roll number'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter your roll number.'
                : null,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submit,
            child: const Text('Submit registration'),
          ),
        ],
      ),
    ),
  );
}

class _CatalogDrawer extends StatelessWidget {
  const _CatalogDrawer();

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [
        const DrawerHeader(child: Text('Course Catalog')),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {
            debugPrint('Drawer Home selected.');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            debugPrint('Drawer About selected.');
            showAboutDialog(
              context: context,
              applicationName: 'Course Catalog',
            );
          },
        ),
      ],
    ),
  );
}

class _CourseActions extends StatelessWidget {
  const _CourseActions();

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Share course'),
          onTap: () {
            debugPrint('Share course selected.');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.bookmark_add_outlined),
          title: const Text('Save for later'),
          onTap: () {
            debugPrint('Save for later selected.');
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
