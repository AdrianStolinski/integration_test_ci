import 'package:counter_app/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => GoRouter.of(context).go('/'),
        ),
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: Listenable.merge([
                emailController,
                passwordController,
              ]),
              builder: (context, child) {
                final email = emailController.text;
                final password = passwordController.text;
                final isEnabled = email.isNotEmpty && password.isNotEmpty;

                return FilledButton(
                  onPressed: isEnabled
                      ? () {
                          userNotifier.email = emailController.text;
                          GoRouter.of(context).go('/');
                        }
                      : null,
                  child: child,
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
