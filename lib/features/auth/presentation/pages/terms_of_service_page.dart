import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0, // 스크롤 시 그림자 효과 제거
        elevation: 0,
        centerTitle: true,
        foregroundColor: const Color(0xFF27282C), // 앱바 콘텐츠(아이콘 등) 색상 설정
        surfaceTintColor:
            Colors.transparent, // 스크롤 시 surface tint 색상 제거 (Material 3)
        title: const Text('이용약관'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * scaleFactor,
          vertical: 16 * scaleFactor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTermSection(
              '제1조 (목적)',
              '이 약관은 하뚜(이하 "회사")가 제공하는 러브키퍼 및 관련 서비스(이하 "서비스")의 이용과 관련하여 회사와 회원 간의 권리ㆍ의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.',
              scaleFactor,
            ),

            _buildTermSection(
              '제2조 (용어의 정의)',
              '① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNumberedItem(
                    '1',
                    '"서비스"란 설치되어 있는 단말기(PC, 휴대형 단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 "하뚜" 및 "러브키퍼"와 관련된 모든 서비스를 의미합니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '2',
                    '"회원"이란 "회사"의 "서비스"에 접속하여 이 약관에 따라 이용계약을 체결하고 "이용자" 아이디(ID)를 부여받은 "이용자"로서 "회사"의 정보를 지속적으로 제공받으며 "회사"가 제공하는 서비스를 지속적으로 이용할 수 있는 자를 말합니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '3',
                    '"아이디(ID)"란 "회원"의 신원 확인 및 "서비스" 이용을 위해 "회원"이 설정하고 "회사"가 승인한 문자와 숫자의 조합을 의미합니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '4',
                    '"비밀번호"란 "회원"이 설정한 문자 또는 숫자의 조합으로, 회원의 기밀을 보호하고, 회원이 부여받은 "아이디"와 일치하는지 확인하기 위한 수단을 의미합니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '5',
                    '"커플"이란 서로 간의 계정이 연동된 "회원" 조합을 의미합니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '6',
                    '"게시물"이란 "회원"이 "서비스상"에 게시한 모든 형태의 정보(코드, 문자, 음성, 음향, 이미지, 영상 등) 및 링크 등을 포함한 문서, 사진, 영상, 각종 파일 등을 의미합니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제3조 (회사정보 등의 제공)',
              '"회사"는 다음 각 호의 사항을 "회원"이 알아보기 쉽도록 "서비스" 내에 표시합니다. 다만, 개인정보처리방침과 약관은 "회원"이 연결화면을 통하여 볼 수 있도록 할 수 있습니다.',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNumberedItem('1', '상호 및 대표자의 성명', scaleFactor),
                  _buildNumberedItem(
                    '2',
                    '영업소 소재지 주소(회원의 불만을 처리할 수 있는 곳의 주소를 포함)',
                    scaleFactor,
                  ),
                  _buildNumberedItem('3', '전화번호, 전자우편주소', scaleFactor),
                  _buildNumberedItem('4', '사업자 등록번호', scaleFactor),
                  _buildNumberedItem('5', '통신판매업 신고번호', scaleFactor),
                  _buildNumberedItem('6', '개인정보처리방침', scaleFactor),
                  _buildNumberedItem('7', '서비스 이용약관', scaleFactor),
                ],
              ),
            ),

            _buildTermSection(
              '제4조 (약관의 게시 및 개정)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회사"는 이 약관의 내용을 "회원"이 쉽게 확인할 수 있도록 "서비스" 초기 화면에 게시합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② "회사"는 "약관의 규제에 관한 법률", "정보통신망 이용촉진 및 정보보호 등에 관한 법률"(이하 "정보통신망법") 등 관련 법령을 위반하지 않는 범위 내에서 본 약관을 개정할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회사"가 약관을 개정하는 경우 적용 일자 및 개정 사유를 명시하여 개정 약관의 효력 발생일 30일 전부터 효력 발생일 전일까지 공개합니다. 단, "회원"에게 불리한 약관 개정 시 전자우편 또는 로그인 시 동의 창을 통해 개별적으로 통지합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '④ "회사"가 본 조에 따라 공지 또는 통지를 하였음에도 불구하고, 개정 약관의 효력 발생일까지 "회원"이 명시적으로 거부 의사를 밝히지 않는 경우, "회원"이 개정 약관에 동의한 것으로 간주됩니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '⑤ "회원"이 개정 약관에 동의하지 않는 경우 "회사"는 개정 약관을 적용할 수 없으며, 이 경우 "회원"은 이용 계약을 해지할 수 있습니다. 단, 기존 약관을 적용할 수 없는 특별한 사유가 있는 경우 "회사"는 이용 계약을 해지할 수 있습니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제5조 (약관의 해석)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회사"는 개별 서비스에 대해 별도의 이용약관(이하 "개별 약관")을 둘 수 있으며, 개별 약관이 본 약관에 충돌하는 경우 개별 약관이 우선 적용됩니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② 본 약관에서 정하지 않은 사항이나 해석에 대해서는 개별 약관, 온라인 디지털콘텐츠산업 발전법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률, 문화체육관광부장관이 정하는 디지털콘텐츠이용자보호지침, 기타 관계법령 또는 상관례에 따릅니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            // 추가 조항들은 같은 패턴으로 계속됩니다
            _buildTermSection(
              '제6조 (이용 계약 체결)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① 회원가입은 "이용자"가 약관에 동의하고 회원 가입을 신청한 후 "회사"가 이러한 신청에 대하여 승낙함으로써 체결됩니다. 또한, "이용자"가 실제로 "서비스"를 이용함으로써 이 약관에 유효하고 취소할 수 없는 동의를 한 것으로 간주됩니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② 만 14세 미만의 "이용자"는 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 부모 등 법정대리인의 동의를 얻은 후에 회원가입을 신청하고 본인의 개인정보를 제공하여야 합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회사"는 원칙적으로 회원 가입 신청을 승낙합니다. 단, 다음 각 호에 해당하는 경우 승낙하지 않거나 사후에 이용 계약을 해지할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '1',
                    '이 약관에 따라 회원 자격을 상실한 적이 있는 경우(단, "회사"의 재가입 승인을 받은 경우 예외)',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '2',
                    '신청 시 허위 정보를 제공하거나 타인의 명의를 도용한 경우',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '3',
                    '"회사"에서 제공하는 정보를 허위로 기재하거나 제출하지 않은 경우',
                    scaleFactor,
                  ),
                  _buildNumberedItem(
                    '4',
                    '이용자의 구책사유로 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '④ "회사"는 회원 유형에 따라 실명 확인을 요구할 수 있으며, 필요 시 본인 인증을 요청할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '⑤ "회사"는 서비스 관련 설비가 부족하거나 기술상 또는 업무상 문제가 있는 경우 승낙을 유보할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '⑥ 제3항과 제4항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, "회사"는 이를 신청자에게 알려야 합니다. "회사"의 귀책사유 없이 신청자에게 통지할 수 없는 경우에는 예외로 합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '⑦ 회원가입계약의 성립 시기는 "회사"의 승낙이 "이용자"에게 도달한 시점으로 합니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            // 이하 모든 조항들도 같은 패턴으로 계속합니다...
            // 예시로 몇 개만 더 추가합니다
            _buildTermSection(
              '제7조 (회원 정보 변경)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회원"은 개인정보관리화면을 통하여 언제든지 자신의 개인정보를 열람하고 수정할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② "회원"은 회원가입신청 시 제공한 정보에 변경 사항이 발생한 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 "회사"에 대하여 그 변경사항을 알려야 합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ 제2항의 변경사항을 "회사"에 알리지 않아 발생한 불이익에 대하여 "회사"는 책임지지 않습니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제8조 (개인정보 보호 의무)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회사"는 관련 법령에 따라 "회원"의 개인정보를 보호하기 위해 노력하며, 개인정보 보호 정책을 공개하고 이를 준수합니다. 단, 제3자의 불법적인 침입이나 개인정보 유출로 인한 피해에 대해서는 책임을 지지 않습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② 개인정보 보호 및 이용에 대한 사항은 관련 법령 및 "회사"의 개인정보처리방침에 따릅니다. 단, "회사" 이외의 링크된 사이트에서는 "회사"의 개인정보처리방침이 적용되지 않으며, 이에 대한 책임은 지지 않습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회원"은 "회사"의 개인정보처리방침에 동의합니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제9조 ("회원"의 "아이디" 및 "비밀번호"의 관리에 대한 의무)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회원"의 "아이디"와 "비밀번호"에 대한 관리 책임은 "회원"에게 있으며, 이를 제3자가 이용하도록 해서는 안 됩니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② "회사"는 "회원"의 "아이디"와 "비밀번호"를 이용하여 발생하는 모든 행위를 "회원" 본인의 행위로 간주합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회원"은 "아이디" 및 "비밀번호"가 도용되거나 제3자가 사용하고 있음을 인지한 경우, 즉시 "회사"에 알리고 "회사"의 안내를 따라야 합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '④ 제3항의 경우, "회원"이 "회사"에 즉시 알리지 않거나 "회사"의 조치에 따르지 않아 발생한 불이익에 대해 "회사"는 책임을 지지 않습니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제10조 ("회원"에 대한 통지)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회사"는 "회원"이 제공한 이메일 주소 또는 기타 연락 수단을 통해 개별적으로 통지할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② "회사"는 불특정 다수 "회원"에 대한 통지의 경우 7일 이상 "서비스" 내 공지사항에 게시함으로써 개별 통지를 대신할 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회원"이 연락처 정보를 최신 상태로 유지하지 않아 개별 통지를 받지 못한 경우, "회사"는 책임을 지지 않습니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            _buildTermSection(
              '제10조 ("회원" 탈퇴 및 자격 상실 등)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(
                    '① "회원"은 "회사"에 언제든지 탈퇴를 요청할 수 있으며, "회사"는 즉시 처리합니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '② "회원"이 본 약관을 위반하거나 관련 법령을 위반한 경우, "회사"는 사전 통보 없이 회원자격을 제한 및 정지시킬 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '③ "회사"가 회원자격을 제한 또는 정지시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 "회사"는 회원자격을 상실시킬 수 있습니다.',
                    scaleFactor,
                  ),
                  _buildParagraph(
                    '④ "회사"는 장기간 로그인하지 않은 "회원"의 계정을 휴면 상태로 전환할 수 있으며, 일정 기간 이후 삭제할 수 있습니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            // 마지막 조항은 하단 여백을 추가합니다
            _buildTermSection(
              '제17조 (준거법 및 재판 관할)',
              '',
              scaleFactor,
              additionalContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph('① 이 약관은 대한민국 법률에 따라 해석됩니다.', scaleFactor),
                  _buildParagraph(
                    '② "회사"와 "이용자" 간 발생한 분쟁에 대해서는 대한민국 법원을 관할 법원으로 합니다.',
                    scaleFactor,
                  ),
                ],
              ),
            ),

            // 제휴문의
            Padding(
              padding: EdgeInsets.only(
                top: 12 * scaleFactor,
                bottom: 40 * scaleFactor,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '제휴문의: ',
                      style: TextStyle(
                        fontSize: 14 * scaleFactor,
                        fontWeight: FontWeight.w600, // 여기도 제목처럼 볼드체 적용
                        height: 1.6,
                        color: const Color(0xFF27282C),
                        letterSpacing: -0.3 * scaleFactor,
                      ),
                    ),
                    TextSpan(
                      text: 'hadoo.co.kr@gmail.com',
                      style: TextStyle(
                        fontSize: 14 * scaleFactor,
                        height: 1.6,
                        color: const Color(0xFF27282C),
                        letterSpacing: -0.3 * scaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 조항 섹션 빌더 (제목 + 내용)
  Widget _buildTermSection(
    String title,
    String content,
    double scaleFactor, {
    Widget? additionalContent,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16 * scaleFactor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w600, // 제목만 볼드체(SemiBold) 적용
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
                      fontWeight: FontWeight.w400, // 일반 텍스트는 Regular 적용
                      height: 1.6,
                      color: const Color(0xFF27282C),
                      letterSpacing: -0.3 * scaleFactor,
                    ),
                  ),
              ],
            ),
          ),
          if (additionalContent != null)
            Padding(
              padding: EdgeInsets.only(top: 8 * scaleFactor),
              child: additionalContent,
            ),
        ],
      ),
    );
  }

  // 번호 붙은 항목 빌더
  Widget _buildNumberedItem(String number, String content, double scaleFactor) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16 * scaleFactor,
        top: 6 * scaleFactor,
        bottom: 6 * scaleFactor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20 * scaleFactor,
            child: Text(
              '$number.',
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400, // 일반 텍스트는 Regular 적용
                height: 1.6,
                color: const Color(0xFF27282C),
                letterSpacing: -0.3 * scaleFactor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400, // 일반 텍스트는 Regular 적용
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

  // 단락 텍스트 빌더
  Widget _buildParagraph(String content, double scaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6 * scaleFactor),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 14 * scaleFactor,
          fontWeight: FontWeight.w400, // 일반 텍스트는 Regular 적용
          height: 1.6,
          color: const Color(0xFF27282C),
          letterSpacing: -0.3 * scaleFactor,
        ),
      ),
    );
  }
}
