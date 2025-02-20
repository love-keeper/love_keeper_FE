import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/core/config/routes/app_router.dart';
import 'package:love_keeper_fe/core/theme/app_theme.dart';
import 'package:love_keeper_fe/core/theme/app_typography.dart';
import 'package:love_keeper_fe/features/onborading/pages/login_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LoveKeeper(),
    ),
  );
}

class LoveKeeper extends ConsumerWidget {
  const LoveKeeper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Love Keeper',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
    );
  }
}
