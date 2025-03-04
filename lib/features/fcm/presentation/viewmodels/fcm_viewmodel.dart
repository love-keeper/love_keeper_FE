import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:love_keeper_fe/features/fcm/data/models/fcm_models.dart';
import 'package:love_keeper_fe/features/fcm/data/repositories/fcm_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_viewmodel.g.dart';

class FCMState {
  final List<PushNotificationResponse> notifications;
  final bool isLoading;
  final String? error;

  FCMState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  FCMState copyWith({
    List<PushNotificationResponse>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return FCMState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class FCMViewModel extends _$FCMViewModel {
  late final FCMRepository _repository;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  FCMState build() {
    _repository = ref.watch(fcmRepositoryProvider);
    _setupFCMListeners();
    _registerTokenOnInit();
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      registerToken(token);
    });
    return FCMState();
  }

  Future<void> _registerTokenOnInit() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        await registerToken(token);
      }
    } catch (e) {
      state = state.copyWith(error: 'FCM 초기화 오류: $e');
    }
  }

  Future<void> registerToken(String token) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.registerToken(token);
      state = state.copyWith(isLoading: false);
      print('FCM 토큰이 성공적으로 등록되었습니다.');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'FCM 토큰 등록 실패: $e');
      print('FCM 토큰 등록 실패: $e');
    }
  }

  Future<void> removeToken(String token) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.removeToken(token);
      state = state.copyWith(isLoading: false);
      print('FCM 토큰이 성공적으로 삭제되었습니다.');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'FCM 토큰 삭제 실패: $e');
      print('FCM 토큰 삭제 실패: $e');
    }
  }

  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      final notifications = await _repository.getPushNotifications();
      state = state.copyWith(notifications: notifications, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '알림 가져오기 실패: $e');
      print('알림 가져오기 실패: $e');
    }
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
      fetchNotifications(); // 알림 수신 시 목록 갱신
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      print('알림 수신 - 제목: ${notification.title}, 내용: ${notification.body}');
      // 로컬 알림 표시 로직 추가 가능
    }
  }
}
