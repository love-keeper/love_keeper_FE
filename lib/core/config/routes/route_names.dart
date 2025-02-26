class RouteNames {
  // Auth Routes
  static const String emailLoginPage = '/emailLogin'; //이메일 로그인 화면
  static const String pwFindingPage = '/pwFinding'; //새 이메일 인증화면
  static const String passwordEditPage = '/pwEdit'; //새 이메일 인증화면
  static const String signupPage = '/signup'; //이메일 가입화면
  static const String emailPasswordInputPage = '/emailPwInput'; //이메일 가입화면
  static const String profileRegistrationPage =
      '/profileRegistration'; //이메일 가입화면
  static const String codeConnectPage = '/codeConnect'; //이메일 가입화면

//onboarding Route
  static const String splashScreen = '/splashScreen';
  static const String onboarding = '/onboarding';

  // Home Routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String mainPage = '/mainPage';

  // Letter Routes (새로 추가)
  //static const String letter = '/letter'; // 화해요청 화면 (LetterPage)

  static const String sendLetter = '/send-letter'; //화해요청 편지 화면
  static const String replyLetter = '/reply-letter'; // 답장 편지 화면
  static const String sendLetterScreen =
      '/send-letter-screen'; // 전송 애니메이션 화면 (SendLetterScreen)
  static const String myPage = '/my'; //마이페이지 화면
  static const String editFieldPage = '/editField'; // 마이페이지 수정화면
  static const String settingsPage = '/settings'; // 마이페지 설정화면
  static const String disconnectPage = '/disconnect'; //연결끊기 화면
  static const String disconnectedScreen = '/disconnected_SC'; //연결끊기 화면
  static const String nicknameEditPage = '/nickname'; //닉네임 편집 화면
  static const String birthdateEditPage = '/birthdate'; //생일 편집 화면
  static const String relationshipStartEditPage =
      '/relationship'; //연애 시작일 편집 화면
  static const String emailEditPage = '/emailEdit'; //이메일 변경 인증화면
  static const String newEmailInputPage = '/newEmailInput'; //새 이메일 설정화면
  static const String newEmailcertification = '/newEmail_CE'; //새 이메일 인증화면
  static const String myPasswordEditPage = '/myPasswordEdit'; //마이 비밀번호 변경화면
}
