import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/letter/presentation/widgets/custom_bottom_sheet_dialog.dart';

class DisconnectPage extends StatelessWidget {
  final String appBarTitle;
  final String richTextPrefix;
  final String richTextSuffix;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final String bottomText; // 이미지 아래 추가 텍스트
  final String actionButtonText; // 두 번째 버튼 텍스트 ("연결 끊기" 또는 "탈퇴하기")
  final double gapBetweenImageAndText1; // 리치텍스트와 이미지 사이 간격
  final double gapBetweenImageAndText2; // 이미지와 이미지 아래 텍스트 사이 간격

  // 바텀 시트 관련 파라미터
  final String dialogTitle; // 예: "정말 연결을 끊으시겠어요?" 또는 "정말 회원 탈퇴하시겠어요?"
  final String
      dialogContent; // 예: "연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다." 또는 탈퇴용 문구
  final String dialogExitText; // 예: "연결 끊기" 또는 "회원 탈퇴"
  final String dialogSaveText; // 예: "돌아가기"
  final VoidCallback onDialogExit; // Exit 버튼 눌렀을 때 수행할 동작 (예: 다른 화면으로 이동)
  final VoidCallback onDialogSave;

  const DisconnectPage({
    Key? key,
    required this.appBarTitle,
    required this.richTextPrefix,
    required this.richTextSuffix,
    required this.imagePath,
    this.imageWidth = 223,
    this.imageHeight = 176,
    required this.bottomText,
    required this.actionButtonText,
    this.gapBetweenImageAndText1 = 78,
    this.gapBetweenImageAndText2 = 69,
    required this.dialogTitle,
    required this.dialogContent,
    required this.dialogExitText,
    required this.dialogSaveText,
    required this.onDialogExit,
    required this.onDialogSave,
  }) : super(key: key);

  void _showCustomExitDialog(BuildContext context, double scaleFactor) {
    // 키보드 닫기
    FocusScope.of(context).unfocus();

    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // 배경 투명 유지
        isDismissible: true,
        enableDrag: true,
        builder: (BuildContext dialogContext) {
          return GestureDetector(
            onTap: () => Navigator.pop(dialogContext),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                // 바텀시트를 하단에 붙이기
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: 288 * scaleFactor, // 바텀시트 높이 조정
                    child: CustomBottomSheetDialog(
                      scaleFactor: scaleFactor,
                      title: dialogTitle,
                      content: dialogContent,
                      exitText: dialogExitText,
                      saveText: dialogSaveText,
                      showSaveButton: true,
                      onExit: () {
                        Navigator.pop(dialogContext); // 바텀 시트 닫기
                        onDialogExit(); // Exit 동작 실행 (예: 다른 페이지로 이동)
                      },
                      onSave: () {
                        Navigator.pop(dialogContext);
                        onDialogSave(); // save버튼 누르면 다른페이지로이동)
                      },
                      onDismiss: () => Navigator.pop(dialogContext),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // 앱바를 숨김
        /*centerTitle: true,
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
            color: const Color(0xff27282C),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0 * scaleFactor),
          child: IconButton(
            icon: Image.asset(
              'assets/images/letter_page/Ic_Back.png',
              width: 24 * scaleFactor,
              height: 24 * scaleFactor,
            ),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
          ),
        ),*/
      ),
      body: Column(
        children: [
          SizedBox(height: 50 * scaleFactor), // 앱바를 숨길경우 추가
          SizedBox(height: 39 * scaleFactor),

          Center(
            child: Container(
              width: 335 * scaleFactor,
              height: 70 * scaleFactor,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24 * scaleFactor,
                    fontWeight: FontWeight.w600,
                    height: 35 / 24,
                    letterSpacing: -0.065 * (24 * scaleFactor),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: richTextPrefix,
                      style: const TextStyle(color: Color(0xffFB5681)),
                    ),
                    TextSpan(
                      text: richTextSuffix,
                      style: const TextStyle(color: Color(0xff27282C)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: gapBetweenImageAndText1 * scaleFactor),

          Center(
            child: Image.asset(
              imagePath,
              width: imageWidth * scaleFactor,
              height: imageHeight * scaleFactor,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: gapBetweenImageAndText2 * scaleFactor),

          // 이미지 아래 추가 텍스트 영역 (335x48)
          Center(
            child: Container(
              width: 335 * scaleFactor,
              height: 48 * scaleFactor,
              alignment: Alignment.center,
              child: Text(
                bottomText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff747784),
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  letterSpacing: -0.025 * (16 * scaleFactor),
                ),
              ),
            ),
          ),
          SizedBox(height: 88 * scaleFactor),
          // 첫 번째 버튼: 334x52, 분홍색, 코너 레디어스 55, "돌아가기" 텍스트
          Center(
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 334 * scaleFactor,
                height: 52 * scaleFactor,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF859B),
                  borderRadius: BorderRadius.circular(55 * scaleFactor),
                ),
                child: Center(
                  child: Text(
                    "돌아가기",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 24 / 16,
                      letterSpacing: -0.025 * (16 * scaleFactor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 0 * scaleFactor),
          // 두 번째 버튼: 162x52, 투명 박스, 텍스트는 actionButtonText ("연결 끊기" 또는 "탈퇴하기")
          Center(
            child: GestureDetector(
              onTap: () => _showCustomExitDialog(context, scaleFactor),
              child: Container(
                width: 162 * scaleFactor,
                height: 52 * scaleFactor,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    actionButtonText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF859B),
                      height: 24 / 16,
                      letterSpacing: -0.025 * (16 * scaleFactor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
