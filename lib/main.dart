import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/core/theme/app_theme.dart';
import 'package:love_keeper_fe/core/config/routes/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null); // 한국어 날짜 포맷 설정

  runApp(const ProviderScope(child: LoveKeeperApp()));
}

class LoveKeeperApp extends ConsumerWidget {
  const LoveKeeperApp({Key? key}) : super(key: key);

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
      title: 'Love Keeper',
      theme: lightTheme,
      darkTheme: darkTheme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
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
            '앱을 초기화하는 데 실패했습니다. 다시 시작해주세요.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
