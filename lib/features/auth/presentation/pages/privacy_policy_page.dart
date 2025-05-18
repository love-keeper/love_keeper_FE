import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _isScrolling = false;

  Widget _buildBulletItem(String text, double scaleFactor) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16 * scaleFactor,
        top: 6 * scaleFactor,
        bottom: 6 * scaleFactor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14 * scaleFactor,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: const Color(0xFF27282C),
              letterSpacing: -0.3 * scaleFactor,
            ),
          ),
          Expanded(
            child: Text.rich(
              _buildRichText(text, scaleFactor),
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: const Color(0xFF27282C),
                letterSpacing: -0.3 * scaleFactor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _isScrolling ? const Color(0xFFF7F8FB) : Colors.white,
          child: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            title: const Text('개인정보 처리방침'),
            titleTextStyle: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.w600,
              height: 26 / 18,
              letterSpacing: -0.45 * scaleFactor,
              color: const Color(0xFF27282C),
            ),
            leading: IconButton(
              icon: Image.asset(
                'assets/images/letter_page/Ic_Back.png',
                width: 24 * scaleFactor,
                height: 24 * scaleFactor,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.dragDetails != null && !_isScrolling) {
              setState(() {
                _isScrolling = true;
              });
            }
          } else if (notification is ScrollEndNotification) {
            if (_isScrolling) {
              setState(() {
                _isScrolling = false;
              });
            }
          }
          return false;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20 * scaleFactor,
            vertical: 16 * scaleFactor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                '',
                '\'하뚜(이하\'회사\')\'가 운영하는 \'러브키퍼\'는 기획부터 종료까지 개인정보 보호 관련 법률 및 규정을 엄격히 준수합니다. 한국의 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「개인정보 보호법」 등을 비롯하여 OECD의 개인정보 보호 가이드라인과 같은 국제 표준을 준수하며 서비스를 제공합니다.',
                scaleFactor,
                links: [
                  '정보통신망법: https://privacy.kisa.or.kr/main.do',
                  '개인정보 보호법: www.spo.go.kr',
                  'OECD 개인정보 보호 가이드라인(영문): www.ctrc.go.kr',
                ],
              ),

              _buildSection(
                '1. 개인정보 처리방침의 의미',
                '\n이 개인정보 처리방침은 정보통신망법을 바탕으로 작성되었으며, 이용자의 개인정보가 회사에서 어떻게 처리되는지 이해하기 쉽고 상세하게 설명하는 것을 목표로 합니다.',
                scaleFactor,
                bulletItems: [
                  '어떤 정보를 수집하는지, 수집한 정보를 어떻게 활용하는지, 필요에 따라 누구와 공유하는지(위탁 또는 제공), 그리고 정보가 사용 목적을 달성했을 때 언제, 어떻게 파기하는지에 대한 내용을 안내합니다.',
                  '이용자는 개인정보의 주체로서 자신의 개인정보에 대해 특정한 권리를 가지며, 이를 어떻게 행사할 수 있는지 설명합니다. 또한, 19세 미만 아동의 개인정보 보호를 위해 법정대리인(부모 등)이 행사할 수 있는 권리도 안내합니다.',
                  '개인정보 침해가 발생할 경우 추가적인 피해를 방지하고, 발생한 피해를 복구할 수 있도록 안내합니다.',
                  '무엇보다도, 회사와 이용자 간의 개인정보 관련 권리와 의무를 규정함으로써 이용자의 개인정보 자기 결정권을 보장합니다.',
                ],
                additionalText: '''이 방침은 다음과 같은 중요한 의미를 가집니다.''',
              ),

              _buildSection(
                '2. 수집하는 개인정보',
                '\n회사는 서비스 이용에 필요한 최소한의 개인정보만을 수집합니다.',
                scaleFactor,
                additionalText: '''**1) 회원 가입 시 수집하는 정보**
필수 항목: **아이디, 비밀번호, 이메일**
선택 항목: **닉네임, 생년월일**
추가적으로, **14세 미만 이용자의 경우** 법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호 등의 정보를 수집할 수 있습니다.

**2) 서비스 이용 중 수집되는 정보**''',
                bulletItems: [
                  '서비스 이용 과정에서 **IP 주소, 쿠키, 방문 기록, 부정 이용 기록, 기기 정보** 등이 자동으로 생성 및 수집될 수 있습니다.',
                  '개별 서비스 이용, 이벤트 응모, 경품 신청 과정에서 추가적인 개인정보가 수집될 수 있으며, 이 경우 수집 항목, 목적, 보관 기간을 사전에 안내합니다.',
                ],
                additionalText2: '''**3) 개인정보 수집 방법**''',
                bulletItems2: [
                  '이용자가 서비스 이용 중 직접 입력한 경우',
                  '고객센터 상담 과정에서 웹페이지, 이메일, 팩스, 전화 등을 통해 수집',
                  '오프라인에서 진행되는 이벤트 및 세미나 등을 통해 서면으로 수집',
                  'PC 웹, 모바일 웹/앱 이용 시 자동으로 생성되는 기기 정보 수집',
                ],
              ),

              _buildSection(
                '3. 수집한 개인정보의 이용 목적',
                '\n수집된 개인정보는 다음과 같은 목적으로 사용됩니다.',
                scaleFactor,
                bulletItems: [
                  '**회원 관리:** 회원 가입 확인, 나이 확인, 법정대리인 동의 진행, 본인 및 법정대리인 인증, 회원 식별, 회원 탈퇴 처리 등',
                  '**서비스 제공 및 개선:** 콘텐츠 제공, 서비스 방문 및 이용 기록 분석, 개인 맞춤형 서비스 제공 및 기존 서비스 개선',
                  '**법률 및 규정 준수:** 이용 약관 위반 회원 제재, 서비스 부정 이용 방지, 불법 거래 방지, 분쟁 해결을 위한 기록 보관, 민원 처리',
                  '**결제 및 배송:** 유료 서비스 이용 시 본인 인증, 결제 및 서비스 상품 제공',
                  '**마케팅 및 홍보:** 이벤트 정보 제공 및 참여 기회 제공, 광고성 정보 제공',
                  '**보안 및 안전한 환경 조성:** 보안 및 프라이버시 보호, 안전한 서비스 환경 조성',
                ],
              ),

              _buildSection(
                '4. 개인정보 제공 및 위탁',
                '\n회사는 원칙적으로 이용자의 동의 없이 개인정보를 외부에 제공하지 않습니다. 단, 다음과 같은 경우에 한해 개인정보가 제공될 수 있습니다.',
                scaleFactor,
                bulletItems: [
                  '이용자가 외부 제휴 서비스를 이용하기 위해 개인정보 제공에 직접 동의한 경우',
                  '법률에 따라 개인정보 제공 의무가 발생하는 경우',
                ],
              ),

              _buildSection(
                '5. 개인정보의 파기',
                '\n원칙적으로, 회원 탈퇴 시 개인정보를 지체 없이 파기합니다.',
                scaleFactor,
                additionalText:
                    '''단, **법령에 의해 일정 기간 보관이 필요한 경우** 해당 기간 동안 안전하게 보관 후 파기합니다.

**1) 별도의 보관 기간이 적용되는 경우**''',
                bulletItems: [
                  '부정 가입 및 이용 방지를 위해 **부정 가입 및 제재 기록**을 6개월간 보관 후 파기',
                  '이용자가 동의한 개인정보 보관 기간이 도래하거나, 서비스 이용 목적이 달성된 경우에는 복구할 수 없는 방식으로 파기',
                  '장기간 로그인하지 않은 이용자의 계정은 "휴면 계정"으로 전환되며, 일정 기간 이후 삭제될 수 있습니다.',
                ],
                additionalText2: '''**2) 파기 방법**''',
                bulletItems2: [
                  '전자적 파일 형태: 복구 불가능한 기술적 방법을 사용하여 안전하게 삭제',
                  '서면 자료: 분쇄 또는 소각하여 파기',
                ],
              ),

              _buildSection(
                '6. 이용자의 권리 및 행사 방법',
                '',
                scaleFactor,
                bulletItems: [
                  '이용자는 언제든지 [MY]에서 개인정보를 열람 및 수정할 수 있습니다.',
                  '개인정보 수집 및 이용 동의 철회는 회원 탈퇴를 통해 가능하며, 14세 미만 아동의 경우 **법정대리인이 개인정보 열람, 수정, 동의 철회를 요청할 수 있습니다.**',
                  '개인정보 오류 정정 요청 시, 해당 오류가 수정될 때까지 정보를 이용하거나 제공하지 않습니다.',
                ],
              ),

              _buildSection(
                '7. 개인정보 보호를 위한 회사의 노력',
                '',
                scaleFactor,
                bulletItems: [
                  '**개인정보 암호화:** 비밀번호, 고유 식별정보, 이메일 주소 등의 민감 정보는 암호화하여 저장 및 관리',
                  '**보안 강화:** 외부 접근이 통제된 공간에 시스템을 설치하고, 주기적인 데이터 백업 및 최신 백신 프로그램 사용',
                  '**네트워크 보안:** 암호화된 통신을 통해 개인정보를 안전하게 전송',
                  '**개인정보 처리 직원 최소화:** 개인정보 취급 인원을 제한하고, 내부 네트워크와 인터넷을 분리하여 보안 유지',
                ],
              ),

              _buildSection(
                '8. 개인정보 보호 책임자 및 문의처',
                '\n개인정보 보호 관련 문의 및 불만 처리를 위해 아래와 같이 개인정보 보호 책임자를 지정하였습니다.',
                scaleFactor,
                bulletItems: [
                  '**개인정보 보호 책임자:** 백채은',
                  '**이메일:** codmsqor@gmail.com',
                ],
              ),

              // 추가 섹션으로 표시
              Padding(
                padding: EdgeInsets.only(top: 16 * scaleFactor),
                child: Text(
                  '또한, 개인정보 침해 신고 및 상담이 필요한 경우 아래 기관에 문의할 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                    color: const Color(0xFF27282C),
                    letterSpacing: -0.3 * scaleFactor,
                  ),
                ),
              ),

              // 관련 기관 정보 리스트
              Padding(
                padding: EdgeInsets.only(top: 8 * scaleFactor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBulletItem(
                      '**개인정보 침해 신고센터:** privacy.kisa.or.kr',
                      scaleFactor,
                    ),
                    _buildBulletItem(
                      '**대검찰청 사이버수사과:** www.spo.go.kr',
                      scaleFactor,
                    ),
                    _buildBulletItem(
                      '**경찰청 사이버수사국:** www.ctrc.go.kr',
                      scaleFactor,
                    ),
                  ],
                ),
              ),
              _buildSection(
                '\n9. 개인정보 처리방침 적용 범위',
                '본 개인정보 처리방침은 회사 및 관련 서비스에 적용됩니다.',
                scaleFactor,
                additionalText: '처리방침 시행일: 2025-03-05',
              ),

              SizedBox(height: 40 * scaleFactor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    double scaleFactor, {
    List<String>? bulletItems,
    List<String>? bulletItems2,
    List<String>? links,
    String? additionalText,
    String? additionalText2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목과 내용
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                  color: const Color(0xFF27282C),
                  letterSpacing: -0.3 * scaleFactor,
                ),
              ),
              if (content.isNotEmpty)
                TextSpan(
                  text: ' $content',
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                    color: const Color(0xFF27282C),
                    letterSpacing: -0.3 * scaleFactor,
                  ),
                ),
            ],
          ),
        ),

        // 링크 목록 (번호 없이)
        if (links != null && links.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  links.map((link) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16 * scaleFactor,
                        top: 6 * scaleFactor,
                        bottom: 6 * scaleFactor,
                      ),
                      child: Text(
                        link,
                        style: TextStyle(
                          fontSize: 14 * scaleFactor,
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                          color: const Color(0xFF27282C),
                          letterSpacing: -0.3 * scaleFactor,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

        // 추가 텍스트가 있는 경우
        if (additionalText != null)
          Padding(
            padding: EdgeInsets.only(top: 8 * scaleFactor),
            child: Text.rich(
              _buildRichText(additionalText, scaleFactor),
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: const Color(0xFF27282C),
                letterSpacing: -0.3 * scaleFactor,
              ),
            ),
          ),

        // 항목 리스트 (글머리 기호로)
        if (bulletItems != null && bulletItems.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  bulletItems.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16 * scaleFactor,
                        top: 6 * scaleFactor,
                        bottom: 6 * scaleFactor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w400,
                              height: 1.6,
                              color: const Color(0xFF27282C),
                              letterSpacing: -0.3 * scaleFactor,
                            ),
                          ),
                          Expanded(
                            child: Text.rich(
                              _buildRichText(item, scaleFactor),
                              style: TextStyle(
                                fontSize: 14 * scaleFactor,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                color: const Color(0xFF27282C),
                                letterSpacing: -0.3 * scaleFactor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),

        // 두 번째 추가 텍스트가 있는 경우
        if (additionalText2 != null)
          Padding(
            padding: EdgeInsets.only(top: 8 * scaleFactor),
            child: Text.rich(
              _buildRichText(additionalText2, scaleFactor),
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: const Color(0xFF27282C),
                letterSpacing: -0.3 * scaleFactor,
              ),
            ),
          ),

        // 두 번째 항목 리스트 (글머리 기호로)
        if (bulletItems2 != null && bulletItems2.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  bulletItems2.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16 * scaleFactor,
                        top: 6 * scaleFactor,
                        bottom: 6 * scaleFactor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w400,
                              height: 1.6,
                              color: const Color(0xFF27282C),
                              letterSpacing: -0.3 * scaleFactor,
                            ),
                          ),
                          Expanded(
                            child: Text.rich(
                              _buildRichText(item, scaleFactor),
                              style: TextStyle(
                                fontSize: 14 * scaleFactor,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                color: const Color(0xFF27282C),
                                letterSpacing: -0.3 * scaleFactor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),

        SizedBox(height: 20 * scaleFactor),
      ],
    );
  }

  // 텍스트에서 **로 감싸진 부분을 볼드체로 변환하는 함수
  TextSpan _buildRichText(String text, double scaleFactor) {
    final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*');
    final List<TextSpan> children = [];
    int lastMatchEnd = 0;

    for (Match match in boldPattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        // 일반 텍스트 추가
        children.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      // 볼드 텍스트 추가
      children.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

      lastMatchEnd = match.end;
    }

    // 마지막 일반 텍스트 추가
    if (lastMatchEnd < text.length) {
      children.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return TextSpan(children: children);
  }
}
