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
      final response = await _repository.markNotificationAsRead(notificationId);

      if (response.code == "COMMON200") {
        // 상태 업데이트: 해당 알림을 읽음 상태로 변경
        state = state.copyWith(
          notifications:
              state.notifications.map((notification) {
                if (notification.id == notificationId) {
                  return notification.copyWith(read: true);
                }
                return notification;
              }).toList(),
        );
      }
    } catch (e) {
      print('알림 읽음 처리 오류: $e');
    }
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('수신된 FCM 메시지 데이터: ${message.data}');
      _handleMessage(message);
      fetchNotifications();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('클릭한 FCM 알림 데이터: ${message.data}');

      // 메시지 데이터에 type과 관련 ID가 있는지 확인
      if (message.data.containsKey('type')) {
        final String type = message.data['type'];
        print('알림 타입: $type');

        if (type == 'LETTER' && message.data.containsKey('letterId')) {
          final letterId = message.data['letterId'];
          print('편지 ID: $letterId');
          // 여기서 편지 상세 페이지로 이동하는 로직 구현
        } else if (type == 'PROMISE' && message.data.containsKey('promiseId')) {
          final promiseId = message.data['promiseId'];
          print('약속 ID: $promiseId');
          // 여기서 약속 상세 페이지로 이동하는 로직 구현
        }
      }

      _handleMessage(message);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('초기 메시지 데이터: ${message.data}');

        // 초기 메시지의 데이터에 type과 관련 ID가 있는지 확인
        if (message.data.containsKey('type')) {
          final String type = message.data['type'];
          print('초기 알림 타입: $type');

          if (type == 'LETTER' && message.data.containsKey('letterId')) {
            final letterId = message.data['letterId'];
            print('초기 편지 ID: $letterId');
            // 여기서 편지 상세 페이지로 이동하는 로직 구현
          } else if (type == 'PROMISE' &&
              message.data.containsKey('promiseId')) {
            final promiseId = message.data['promiseId'];
            print('초기 약속 ID: $promiseId');
            // 여기서 약속 상세 페이지로 이동하는 로직 구현
          }
        }

        _handleMessage(message);
      }
    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
      registerToken(token);
    });
  }

  void _handleMessage(RemoteMessage message) {
    final notification = message.notification;

    // 데이터 필드 확인 추가
    print('FCM 메시지 데이터(_handleMessage): ${message.data}');
    if (message.data.containsKey('type')) {
      print('알림 타입(_handleMessage): ${message.data['type']}');
    }
    if (message.data.containsKey('letterId')) {
      print('편지 ID(_handleMessage): ${message.data['letterId']}');
    }
    if (message.data.containsKey('promiseId')) {
      print('약속 ID(_handleMessage): ${message.data['promiseId']}');
    }

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
