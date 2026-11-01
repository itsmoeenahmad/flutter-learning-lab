import 'package:flutter/material.dart';

/// Week 11: practice the authentication UI before connecting Firebase.
class AuthProfileDemoPage extends StatefulWidget {
  const AuthProfileDemoPage({super.key});

  @override
  State<AuthProfileDemoPage> createState() => _AuthProfileDemoPageState();
}

class _AuthProfileDemoPageState extends State<AuthProfileDemoPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _signedInEmail;

  void _signIn() {
    if (!_formKey.currentState!.validate()) {
      debugPrint('Authentication form is invalid.');
      return;
    }

    setState(() => _signedInEmail = _emailController.text.trim());
    debugPrint('Local authentication UI completed for $_signedInEmail');
  }

  void _signOut() {
    setState(() => _signedInEmail = null);
    debugPrint('Local authentication UI signed out.');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_signedInEmail != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user_outlined, size: 56),
              const SizedBox(height: 12),
              const Text('Signed-in UI state'),
              Text(_signedInEmail!),
              const SizedBox(height: 12),
              const Text(
                'Connect Firebase to create a real account and profile.',
              ),
              OutlinedButton(onPressed: _signOut, child: const Text('Logout')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication Demo')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'This is UI practice only. It does not create a real account.',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value == null || !value.contains('@')
                  ? 'Enter a valid email address.'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) => value == null || value.length < 6
                  ? 'Use at least 6 characters.'
                  : null,
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _signIn, child: const Text('Sign In')),
          ],
        ),
      ),
    );
  }
}
