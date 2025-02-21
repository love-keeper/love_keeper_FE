import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final result = await ref
                    .read(authViewModelProvider.notifier)
                    .sendCode('qkrehdrb0813@gmail.com');
                print('Button result: $result');
              } catch (e) {
                print('Button error: $e');
              }
            },
            child: const Text('Test SendCode'),
          ),
        ),
      ),
    );
  }
}
