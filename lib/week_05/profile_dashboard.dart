import 'package:flutter/material.dart';

/// Week 05: core widgets, layouts, cards, buttons, and reusable UI.
class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Profile')),
    // ListView keeps the screen scrollable on smaller devices.
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Row places the profile picture and text side by side.
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(radius: 34, child: Icon(Icons.person, size: 38)),
                SizedBox(width: 16),
                // Expanded gives the text the remaining horizontal space.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ayesha Khan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('BS Computer Science · 5th Semester'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Three Expanded widgets share this row's width equally.
        Row(
          children: const [
            Expanded(
              child: _SummaryCard('Attendance', '92%', Icons.event_available),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                'Labs Done',
                '04',
                Icons.assignment_turned_in,
              ),
            ),
            SizedBox(width: 12),
            Expanded(child: _SummaryCard('Semester', '05', Icons.school)),
          ],
        ),
        const SizedBox(height: 20),
        Text('Current Courses', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const _CourseCard(
          Icons.phone_android,
          'Mobile Application Development',
          'Flutter and Dart',
        ),
        const _CourseCard(
          Icons.storage,
          'Database Systems',
          'SQL and data modelling',
        ),
        const _CourseCard(
          Icons.code,
          'Software Engineering',
          'Design and testing',
        ),
        const SizedBox(height: 16),
        // Container combines padding, color, and rounded corners.
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Build small widgets first, then compose the screen.'),
          ),
        ),
        const SizedBox(height: 20),
        // Different button styles show primary and secondary actions.
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  debugPrint('Edit Profile button pressed.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile editing is coming soon.'),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit profile'),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: OutlinedButton.icon(
                onPressed: () {
                  debugPrint('Contact button pressed.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contact request sent.')),
                  );
                },
                icon: const Icon(Icons.mail_outline),
                label: const Text('Contact'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard(this.label, this.value, this.icon);
  final String label, value;
  final IconData icon;
  @override
  // This reusable widget prevents repeated card code in the screen.
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

class _CourseCard extends StatelessWidget {
  const _CourseCard(this.icon, this.title, this.subtitle);
  final IconData icon;
  final String title, subtitle;
  @override
  // This reusable card receives different values through its constructor.
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    ),
  );
}
