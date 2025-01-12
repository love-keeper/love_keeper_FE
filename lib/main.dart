import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/login_page.dart';


void main() {
  runApp(
    ProviderScope(
      child: const LoveKeeper(),
    ),
  );
}

class LoveKeeper extends StatelessWidget {
  const LoveKeeper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Love Keeper',
      home: LoginPage(),
    );
  }
}
