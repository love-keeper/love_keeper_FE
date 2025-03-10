import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:love_keeper/core/config/di/dio_module.dart';
import 'package:love_keeper/features/fcm/data/models/fcm_models.dart';
import 'package:love_keeper/features/fcm/data/repositories/fcm_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fcm_viewmodel.g.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FCMState {
  final List<PushNotificationResponse> notifications;
  final bool isLoading; // 초기 로딩
  final bool isLoadingMore; // 추가 로딩(무한 스크롤)
  final String? error;
  final int page;
  final bool hasNext;

  FCMState({
    this.notifications = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.page = 0,
    this.hasNext = true,
  });

  FCMState copyWith({
    List<PushNotificationResponse>? notifications,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? page,
    bool? hasNext,
  }) {
    return FCMState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
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
    initializeFCM();
    return FCMState();
  }

  Future<void> initializeFCM() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _initLocalNotifications();
    _setupFCMListeners();
  }

  Future<void> _initLocalNotifications() async {
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> registerToken(String token) async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        throw Exception('No access token available for FCM token registration');
      }
      print('Registering FCM token with access token: $accessToken');
      await _repository.registerToken(token);
      state = state.copyWith(isLoading: false);
      print('FCM 토큰 등록 성공: $token');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'FCM 토큰 등록 실패: $e');
      print('FCM 토큰 등록 실패: $e');
    }
  }

  Future<void> registerTokenOnLogin() async {
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      await registerToken(token);
    }
  }

  Future<void> fetchNotifications({bool loadMore = false}) async {
    if (state.isLoading ||
        (loadMore && state.isLoadingMore) ||
        (!loadMore && state.page > 0 && !state.hasNext))
      return;

    if (loadMore) {
      state = state.copyWith(isLoadingMore: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      final response = await _repository.getPushNotifications(
        page: loadMore ? state.page + 1 : 0,
        size: 10,
      );

      final updatedNotifications =
          loadMore
              ? [...state.notifications, ...response.notifications]
              : response.notifications;

      state = state.copyWith(
        notifications: updatedNotifications,
        isLoading: false,
        isLoadingMore: false,
        page: response.page,
        hasNext: response.hasNext,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: '알림 가져오기 실패: $e',
      );
    }
  }

  Future<void> markAsRead(int notificationId) async {
    try {
      await _repository.markNotificationAsRead(notificationId);
      final updatedNotifications =
          state.notifications.map((notif) {
            if (notif.id == notificationId) {
              return notif.copyWith(read: true);
            }
            return notif;
          }).toList();
      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      state = state.copyWith(error: '알림 읽음 처리 실패: $e');
    }
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
      fetchNotifications();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
      registerToken(token);
    });
  }

  void _handleMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      print('알림 수신 - 제목: ${notification.title}, 내용: ${notification.body}');
      _showNotification(notification);
    }
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platformDetails = NotificationDetails(iOS: iOSDetails);

    await _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformDetails,
    );
  }
}
