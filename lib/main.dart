import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/core/theme/app_theme.dart';
import 'package:love_keeper_fe/core/config/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: LoveKeeperMyPage()));
}

class LoveKeeperMyPage extends ConsumerWidget {
  const LoveKeeperMyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    final lightTheme = AppTheme.light().copyWith(
      textTheme: AppTheme.light().textTheme.apply(fontFamily: 'Pretendard'),
    );
    final darkTheme = AppTheme.dark().copyWith(
      textTheme: AppTheme.dark().textTheme.apply(fontFamily: 'Pretendard'),
    );

    return MaterialApp.router(
      title: 'Love Keeper - MyPage',
      theme: lightTheme,
      darkTheme: darkTheme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

/*
//편지 화면 디버깅용 main
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/core/theme/app_theme.dart';
import 'package:love_keeper_fe/core/config/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: LoveKeeper()));
}

class LoveKeeper extends ConsumerWidget {
  const LoveKeeper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Love Keeper',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
*/
