// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/di/app_providers.dart';
import 'core/config/routes/app_router.dart';
import 'core/utils/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final providerContainer = await initializeProviders();
    runApp(
      ProviderInitializer(
        providersFuture: Future.value(providerContainer),
        builder: (container) => MyApp(container: container),
      ),
    );
  } catch (e, stackTrace) {
    logger.error('Failed to initialize app', error: e, stackTrace: stackTrace);
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  final ProviderContainer container;

  const MyApp({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    final router = container.read(appRouterProvider);

    return MaterialApp.router(
      title: 'Love Keeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Failed to initialize the app. Please restart.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
