class OnboardingPageModel {
  final String title;
  final String? subtitle;
  final String iconAsset; // SVG 아이콘을 위한 경로

  const OnboardingPageModel({
    required this.title,
    this.subtitle,
    required this.iconAsset,
  });

  static const List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: '애인과의 특별한 약속!',
      subtitle: '서로 약속을 만들고 지켜보세요.\n모든 약속은 보관함에서 확인 가능합니다.',
      iconAsset: 'assets/onboarding/onboarding_1.png',
    ),
    OnboardingPageModel(
      title: '편지로 마음을 전해요.',
      subtitle: '애인과 서로 설렘 가득한\n사랑의 마음을 편지로 전달해 보세요.',
      iconAsset: 'assets/onboarding/onboarding_2.png',
    ),
    OnboardingPageModel(
      title: '쪽지를 주고 받아요.',
      subtitle: '서로 쪽지를 주고 받아보세요!\n쪽지는 24시간 내에만 확인가능합니다.',
      iconAsset: 'assets/onboarding/onboarding_3.png',
    ),
    OnboardingPageModel(
      title: '기록을 확인할 수 있어요.',
      subtitle: '약속, 쪽지, 편지를 언제 어디서\n주고 받았는지 앨범에서 확인할 수 있어요.',
      iconAsset: 'assets/onboarding/onboarding_4.png',
    ),
    OnboardingPageModel(
      title: '여러분의 사랑 지킴이!\nLOVE KEEPER와 함께 해요.',
      iconAsset: 'assets/onboarding/onboarding_5.png',
    ),
  ];
}