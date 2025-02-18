// lib/core/config/di/app_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/dio_client.dart';
import '../routes/app_router.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

Future<ProviderContainer> initializeProviders() async {
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(
        await SharedPreferences.getInstance(),
      ),
    ],
  );

  // Pre-initialize essential providers
  container.read(dioClientProvider);
  container.read(appRouterProvider);

  return container;
}

class ProviderInitializer extends StatelessWidget {
  final Widget Function(ProviderContainer) builder;
  final Future<ProviderContainer> providersFuture;

  const ProviderInitializer({
    Key? key,
    required this.builder,
    required this.providersFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProviderContainer>(
      future: providersFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UncontrolledProviderScope(
            container: snapshot.data!,
            child: builder(snapshot.data!),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
