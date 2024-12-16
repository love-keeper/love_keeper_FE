// lib/features/splash/view_models/splash_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import '../models/splash_state.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  SplashState build() {
    return const SplashState();
  }

  Future<void> initialize(GoRouter router) async {
    state = state.copyWith(isLoading: true);
    
    try {
      // 스플래시 화면에서 로고 애니메이션을 보여주기 위한 지연 시간을 줍니다.
      await Future.delayed(const Duration(seconds: 2));
      
      // 에러가 없는 경우에만 다음 화면으로 이동합니다.
      // state.error가 null인지 확인하여 에러 상태를 체크합니다.
      if (state.error == null) {
        // 에러가 없다면 로그인 화면으로 이동합니다.
        router.go('/login');
      }

      // 로딩 상태를 false로 변경합니다.
      state = state.copyWith(isLoading: false);
      
    } catch (e) {
      // 에러가 발생한 경우 에러 메시지를 상태에 저장하고
      // 로딩 상태를 false로 변경합니다.
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}