import 'package:counter_app/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const _UserContainer(),
            const SizedBox(height: 20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('IncrementFab'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}

class _UserContainer extends StatelessWidget {
  const _UserContainer();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userNotifier,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: ${userNotifier.email}'),
              const SizedBox(height: 8),
              if (userNotifier.isSignedIn)
                FilledButton(
                  key: const ValueKey('LogoutBtn'),
                  onPressed: () => userNotifier.email = null,
                  child: const Text('Logout'),
                )
              else
                FilledButton(
                  key: const ValueKey('LoginBtn'),
                  onPressed: () => GoRouter.of(context).go('/login'),
                  child: const Text('Login'),
                )
            ],
          ),
        );
      },
    );
  }
}
