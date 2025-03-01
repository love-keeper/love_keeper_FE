// 사용 안함!!!

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
// import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
// import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
// import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

// class EmailEditPage extends ConsumerStatefulWidget {
//   const EmailEditPage({super.key});

//   @override
//   _EmailEditPageState createState() => _EmailEditPageState();
// }

// class _EmailEditPageState extends ConsumerState<EmailEditPage> {
//   final TextEditingController _emailController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _sendEmailCode(); // 페이지 로드 시 인증 코드 전송
//     _emailController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _sendEmailCode() async {
//     final authState = ref.read(authStateNotifierProvider);
//     final currentEmail = authState.email ?? '';
//     if (currentEmail.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('현재 이메일이 설정되지 않았습니다.')),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       await ref
//           .read(membersViewModelProvider.notifier)
//           .sendEmailCode(currentEmail);
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('인증 코드가 전송되었습니다.')),
//       );
//     } catch (e) {
//       debugPrint('Send email code error: $e');
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('인증 코드 전송 실패: $e')),
//       );
//     }
//   }

//   Future<void> _updateEmail() async {
//     final inputEmail = _emailController.text;
//     if (!emailRegex.hasMatch(inputEmail)) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final result = await ref
//           .read(membersViewModelProvider.notifier)
//           .updateEmail(inputEmail);
//       setState(() {
//         _isLoading = false;
//       });
//       if (result == '이메일 변경 성공') {
//         context.pop();
//       }
//     } catch (e) {
//       debugPrint('Update email error: $e');
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('이메일 변경 실패: $e')),
//       );
//     }
//   }

//   final RegExp emailRegex = RegExp(
//     r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
//     caseSensitive: false,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final double deviceWidth = MediaQuery.of(context).size.width;
//     const double baseWidth = 375.0;
//     final double scaleFactor = deviceWidth / baseWidth;
//     final bool hasText = _emailController.text.isNotEmpty;

//     final String guideMessage =
//         hasText && !emailRegex.hasMatch(_emailController.text)
//             ? '올바른 이메일 형식을 입력해 주세요.'
//             : '';

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           '이메일 변경',
//           style: TextStyle(
//             fontSize: 18 * scaleFactor,
//             fontWeight: FontWeight.w600,
//             height: 26 / 18,
//             letterSpacing: -0.45 * scaleFactor,
//             color: const Color(0xFF27282C),
//           ),
//         ),
//         leading: IconButton(
//           icon: Image.asset(
//             'assets/images/letter_page/Ic_Back.png',
//             width: 24 * scaleFactor,
//             height: 24 * scaleFactor,
//           ),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       bottomNavigationBar: SaveButtonWidget(
//         scaleFactor: scaleFactor,
//         enabled: hasText && guideMessage.isEmpty && !_isLoading,
//         buttonText: '변경하기',
//         onPressed: _isLoading ? null : _updateEmail,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
//             child: EditFieldWidget(
//               label: '이메일',
//               hintText: '새로운 이메일 주소를 입력해 주세요.',
//               controller: _emailController,
//               scaleFactor: scaleFactor,
//               autofocus: true,
//               guideMessage: guideMessage,
//             ),
//           ),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
