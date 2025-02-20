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
      title: '사과 편지 작성하기',
      subtitle:
          '애인과 다툼이 있었다면, 사과의 마음을 편지로 전해 보세요.\n서로의 진심을 나누며 이해하는 시간을 가질 수 있어요.',
      iconAsset: 'assets/images/onboarding/Img_Onboarding_01_letter.png',
    ),
    OnboardingPageModel(
      title: '우리만의 규칙 정하기',
      subtitle: '더 단단한 관계를 위해 약속을 만들어 보세요.\n모든 약속은 보관함에서 확인할 수 있습니다.',
      iconAsset: 'assets/images/onboarding/Img_Onboarding_02_promise.png',
    ),
    OnboardingPageModel(
      title: '통계로 확인하는 추억',
      subtitle: '우리만의 소중한 기록을\n날짜별로 확인할 수 있어요.',
      iconAsset: 'assets/images/onboarding/Img_Onboarding_04_calender.png',
    ),
    OnboardingPageModel(
      title: '여러분의 사랑 지킴이!\nLOVE KEEPER와 함께해요.',
      subtitle: ' ',
      iconAsset: 'assets/images/onboarding/Img_Onboarding_05_logo.png',
    ),
  ];
}
