class RouteNames {
  // Auth Routes
  static const String onboarding = '/';
  static const String emailLogin = '/email-login';
  static const String emailSignup = '/email-signup';
  static const String passwordReset = '/password-reset';

  // Home Routes
  static const String home = '/home';
  static const String profile = '/profile';

  // Letter Routes (새로 추가)
  //static const String letter = '/letter'; // 화해요청 화면 (LetterPage)

  static const String sendLetter = '/send-letter'; //화해요청 편지 화면
  static const String replyLetter = '/reply-letter'; // 답장 편지 화면
  static const String sendLetterScreen =
      '/send-letter-screen'; // 전송 애니메이션 화면 (SendLetterScreen)
}
