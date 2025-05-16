import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:love_keeper/core/config/di/dio_module.dart';
import 'package:love_keeper/features/fcm/data/models/fcm_models.dart';
import 'package:love_keeper/features/fcm/data/repositories/fcm_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

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
  bool _isInitialized = false; // 중복 초기화 방지를 위한 플래그 추가

  @override
  FCMState build() {
    _repository = ref.watch(fcmRepositoryProvider);
    initializeFCM();
    return FCMState();
  }

  Future<void> initializeFCM() async {
    // 중복 초기화 방지
    if (_isInitialized) {
      print("FCM 이미 초기화됨");
      return;
    }

    try {
      // 알림 권한 요청
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        criticalAlert: false,
        announcement: false,
        carPlay: false,
      );
      print("알림 권한 요청 완료");

      // 포그라운드 알림 표시 설정 추가
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      if (Platform.isIOS) {
        String? apnsToken;
        for (int i = 0; i < 5; i++) {
          // 더 긴 지연 시간 추가 (지수적 증가)
          await Future.delayed(Duration(seconds: (i + 1) * 2));

          apnsToken = await _firebaseMessaging.getAPNSToken();
          print("APNS 토큰 시도 ${i + 1}/5: ${apnsToken ?? 'null'}");

          if (apnsToken != null) {
            print("APNS 토큰 생성 성공: $apnsToken");
            break;
          }
        }

        if (apnsToken == null) {
          print("APNS 토큰 생성 실패, FCM 토큰으로 계속 진행");
        }
      }

      await _initLocalNotifications();
      _setupFCMListeners();
      await testFCM();

      // 테스트 로컬 알림 표시 (3초 후)
      await Future.delayed(Duration(seconds: 3));
      await testLocalNotification();

      // 초기화 완료 표시
      _isInitialized = true;
    } catch (e) {
      print("FCM 초기화 오류: $e");
    }
  }

  // 테스트용 로컬 알림 표시 함수
  Future<void> testLocalNotification() async {
    print('📱 테스트 로컬 알림 표시 시도');

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platformDetails = NotificationDetails(iOS: iOSDetails);

    try {
      await _flutterLocalNotificationsPlugin.show(
        100, // 테스트용 ID
        '테스트 알림',
        '이것은 로컬 테스트 알림입니다.',
        platformDetails,
      );
      print('✅ 테스트 로컬 알림 표시 성공');
    } catch (e) {
      print('❌ 테스트 로컬 알림 표시 실패: $e');
    }
  }

  // FCM 테스트 함수
  Future<void> testFCM() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print('==========================================');
      print('FCM 토큰: $token');
      print('==========================================');

      if (token != null) {
        await Clipboard.setData(ClipboardData(text: token));
        print('FCM 토큰이 클립보드에 복사되었습니다.');

        // 토큰 등록 시도 (선택적)
        try {
          await registerToken(token);
        } catch (e) {
          print('토큰 등록 시도 중 오류 발생 (무시됨): $e');
        }
      }
    } catch (e) {
      print('FCM 토큰 가져오기 오류: $e');
    }
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
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        print('로컬 알림 응답 수신: ${details.payload}');
      },
    );
  }

  Future<void> registerToken(String token) async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        print('로그인되지 않음: FCM 토큰 등록 연기');
        state = state.copyWith(isLoading: false);
        return;
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
      print('🔔 ======== Foreground 메시지 수신 ========');
      _printDetailedMessageInfo(message);
      _handleMessage(message);
      fetchNotifications();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🔔 ======== 백그라운드 알림 클릭 ========');
      _printDetailedMessageInfo(message);
      _handleNotificationClick(message);
      _handleMessage(message);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('🔔 ======== 앱 시작 초기 메시지 ========');
        _printDetailedMessageInfo(message);
        _handleNotificationClick(message);
        _handleMessage(message);
      }
    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
      registerToken(token);
    });
  }

  void _printDetailedMessageInfo(RemoteMessage message) {
    print('==================== FCM 메시지 상세 정보 ====================');
    print('messageId: ${message.messageId}');
    print('senderId: ${message.senderId}');
    print('category: ${message.category}');
    print('collapseKey: ${message.collapseKey}');
    print('contentAvailable: ${message.contentAvailable}');
    print('messageType: ${message.messageType}');
    print('ttl: ${message.ttl}');

    if (message.notification != null) {
      print('notification.title: ${message.notification!.title}');
      print('notification.body: ${message.notification!.body}');
      print('notification.android: ${message.notification!.android}');
      print('notification.apple: ${message.notification!.apple}');
    } else {
      print('notification: null');
    }

    print('data: ${message.data}');
    if (message.data.isNotEmpty) {
      print('--- data 필드 상세 분석 ---');
      message.data.forEach((key, value) {
        print('key: "$key", value: "$value", type: ${value.runtimeType}');
      });
    }
    print('=================================================================');
  }

  Map<String, dynamic> extractNotificationData(RemoteMessage message) {
    final data = message.data;
    final result = <String, dynamic>{};

    final possibleTypeKeys = [
      'type',
      'Type',
      'TYPE',
      'notification_type',
      'notificationType',
    ];
    final possibleLetterIdKeys = [
      'letterId',
      'letter_id',
      'LetterID',
      'LETTER_ID',
      'letterid',
    ];
    final possiblePromiseIdKeys = [
      'promiseId',
      'promise_id',
      'PromiseID',
      'PROMISE_ID',
      'promiseid',
    ];

    for (final key in possibleTypeKeys) {
      if (data.containsKey(key)) {
        result['type'] = data[key];
        print('FCM 타입 찾음: 키=$key, 값=${data[key]}');
        break;
      }
    }

    if (result['type'] == 'LETTER' ||
        result['type']?.toLowerCase().contains('letter') == true) {
      for (final key in possibleLetterIdKeys) {
        if (data.containsKey(key)) {
          result['contentId'] = int.tryParse(data[key].toString());
          print('편지 ID 찾음: 키=$key, 값=${data[key]}');
          break;
        }
      }
    } else if (result['type'] == 'PROMISE' ||
        result['type']?.toLowerCase().contains('promise') == true) {
      for (final key in possiblePromiseIdKeys) {
        if (data.containsKey(key)) {
          result['contentId'] = int.tryParse(data[key].toString());
          print('약속 ID 찾음: 키=$key, 값=${data[key]}');
          break;
        }
      }
    }

    print('추출된 데이터: $result');
    return result;
  }

  void _handleNotificationClick(RemoteMessage message) {
    final extractedData = extractNotificationData(message);
    final type = extractedData['type'] as String?;
    final contentId = extractedData['contentId'] as int?;

    print('알림 클릭 처리: type=$type, contentId=$contentId');
  }

  void _handleMessage(RemoteMessage message) {
    final notification = message.notification;

    if (notification != null) {
      print('🔔 알림 수신 - 제목: ${notification.title}, 내용: ${notification.body}');
      _showNotification(notification);
    } else {
      print('⚠️ 알림 데이터는 있지만 notification 객체가 null입니다');

      // 데이터 메시지인 경우 수동으로 알림 생성
      if (message.data.isNotEmpty) {
        final title = message.data['title'] ?? '새 알림';
        final body = message.data['body'] ?? '새로운 메시지가 도착했습니다';

        print('📱 데이터 메시지로부터 알림 생성: 제목=$title, 내용=$body');

        _showCustomNotification(title, body);
      }
    }
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    print('📱 알림 표시 시도 - 제목: ${notification.title}');

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platformDetails = NotificationDetails(iOS: iOSDetails);

    try {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
      );
      print('✅ 알림 표시 성공');
    } catch (e) {
      print('❌ 알림 표시 실패: $e');
    }
  }

  Future<void> _showCustomNotification(String title, String body) async {
    print('📱 커스텀 알림 표시 시도 - 제목: $title');

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platformDetails = NotificationDetails(iOS: iOSDetails);

    try {
      await _flutterLocalNotificationsPlugin.show(
        title.hashCode,
        title,
        body,
        platformDetails,
      );
      print('✅ 커스텀 알림 표시 성공');
    } catch (e) {
      print('❌ 커스텀 알림 표시 실패: $e');
    }
  }
}
