import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'features/members/presentation/viewmodels/members_viewmodel.dart';
import 'features/drafts/presentation/viewmodels/drafts_viewmodel.dart';
import 'features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'features/promises/presentation/viewmodels/promises_viewmodel.dart';
import 'features/calendar/presentation/viewmodels/calendar_viewmodel.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('API Test')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Auth API
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref.read(authViewModelProvider.notifier).signup(
                            email: 'eastking7979@hufs.ac.kr',
                            nickname: 'EastKing',
                            birthDate: '1990-01-01',
                            provider: 'LOCAL',
                            password: 'ehdfprl77@',
                            providerId: null,
                            profileImage: null,
                          );
                      print('Signup successful');
                    } catch (e) {
                      print('Signup error: $e');
                    }
                  },
                  child: const Text('Signup'),
                ),
                const SizedBox(height: 10),
                // 나머지 버튼은 변경 없음 (생략)
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref.read(authViewModelProvider.notifier).login(
                            email: 'eastking7979@hufs.ac.kr',
                            provider: 'local',
                            password: 'ehdfprl77@',
                          );
                      final prefs = await SharedPreferences.getInstance();
                      print(
                          'Post-login access token: ${prefs.getString('access_token')}');
                    } catch (e) {
                      print('Login error: $e');
                    }
                  },
                  child: const Text('Login (Required for Token)'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .sendCode('eastking7979@hufs.ac.kr');
                      print('Send code result: $result');
                    } catch (e) {
                      print('Send code error: $e');
                    }
                  },
                  child: const Text('Send Code'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .verifyCode('eastking7979@hufs.ac.kr', 920932);
                      print('Verify code result: $result');
                    } catch (e) {
                      print('Verify code error: $e');
                    }
                  },
                  child: const Text('Verify Code'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .logout();
                      print('Logout result: $result');
                    } catch (e) {
                      print('Logout error: $e');
                    }
                  },
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .resetPasswordRequest('eastking7979@hufs.ac.kr');
                      print('Reset password request result: $result');
                    } catch (e) {
                      print('Reset password request error: $e');
                    }
                  },
                  child: const Text('Reset Password Request'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .resetPassword(
                            'eastking7979@hufs.ac.kr',
                            'ehdfprl77@',
                            'ehdfprl77@',
                          );
                      print('Reset password result: $result');
                    } catch (e) {
                      print('Reset password error: $e');
                    }
                  },
                  child: const Text('Reset Password'),
                ),
                const Divider(height: 20),

                // Couples API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .generateCode();
                      print('Generate code result: ${result.inviteCode}');
                    } catch (e) {
                      print('Generate code error: $e');
                    }
                  },
                  child: const Text('Generate Couple Code'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .connect('QOFC23TI');
                      print('Connect couple result: $result');
                    } catch (e) {
                      print('Connect couple error: $e');
                    }
                  },
                  child: const Text('Connect Couple'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .getDaysSinceStarted();
                      print('Days since started result: $result');
                    } catch (e) {
                      print('Days since started error: $e');
                    }
                  },
                  child: const Text('Get Days Since Started'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .getStartDate();
                      print('Start date result: $result');
                    } catch (e) {
                      print('Get start date error: $e');
                    }
                  },
                  child: const Text('Get Start Date'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .updateStartDate('2021-01-01');
                      print('Update start date result: $result');
                    } catch (e) {
                      print('Update start date error: $e');
                    }
                  },
                  child: const Text('Update Start Date'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(couplesViewModelProvider.notifier)
                          .deleteCouple();
                      print('Delete couple result: $result');
                    } catch (e) {
                      print('Delete couple error: $e');
                    }
                  },
                  child: const Text('Delete Couple'),
                ),
                const Divider(height: 20),

                // Members API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(membersViewModelProvider.notifier)
                          .updateNickname('동꾸');
                      print('Update nickname result: $result');
                    } catch (e) {
                      print('Update nickname error: $e');
                    }
                  },
                  child: const Text('Update Nickname'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(membersViewModelProvider.notifier)
                          .updateBirthday('1999-08-21');
                      print('Update birthday result: $result');
                    } catch (e) {
                      print('Update birthday error: $e');
                    }
                  },
                  child: const Text('Update Birthday'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(membersViewModelProvider.notifier)
                          .updatePassword(
                            'ehdfprl77@',
                            'qkrehdrb123@',
                            'qkrehdrb123@',
                          );
                      print('Update password result: $result');
                    } catch (e) {
                      print('Update password error: $e');
                    }
                  },
                  child: const Text('Update Password'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final file =
                          File('path/to/test/image.jpg'); // 실제 파일 경로로 교체
                      final result = await ref
                          .read(membersViewModelProvider.notifier)
                          .updateProfileImage(file);
                      print('Update profile image result: $result');
                    } catch (e) {
                      print('Update profile image error: $e');
                    }
                  },
                  child: const Text('Update Profile Image'),
                ),
                const Divider(height: 20),


                // Drafts API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(draftsViewModelProvider.notifier)
                          .createDraft(1, '미안해...');
                      print('Create draft result: $result');
                    } catch (e) {
                      print('Create draft error: $e');
                    }
                  },
                  child: const Text('Create Draft'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final draft = await ref
                          .read(draftsViewModelProvider.notifier)
                          .getDraft(1);
                      print(
                          'Get draft result: order=${draft.order}, content=${draft.content}');
                    } catch (e) {
                      print('Get draft error: $e');
                    }
                  },
                  child: const Text('Get Draft'),
                ),
                const Divider(height: 20),

                // Letters API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(lettersViewModelProvider.notifier)
                          .createLetter('어쩔티비');
                      print('Create letter result: $result');
                    } catch (e) {
                      print('Create letter error: $e');
                    }
                  },
                  child: const Text('Create Letter'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final letterList = await ref
                          .read(lettersViewModelProvider.notifier)
                          .getLetterList(0, 10);
                      print(
                          'Get letter list result: ${letterList.letterList.map((e) => e.content).toList()}');
                    } catch (e) {
                      print('Get letter list error: $e');
                    }
                  },
                  child: const Text('Get Letter List'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final count = await ref
                          .read(lettersViewModelProvider.notifier)
                          .getLetterCount();
                      print('Get letter count result: $count');
                    } catch (e) {
                      print('Get letter count error: $e');
                    }
                  },
                  child: const Text('Get Letter Count'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final letterList = await ref
                          .read(lettersViewModelProvider.notifier)
                          .getLettersByDate('2025-02-13', 0, 10);
                      print(
                          'Get letters by date result: ${letterList.letterList.map((e) => e.content).toList()}');
                    } catch (e) {
                      print('Get letters by date error: $e');
                    }
                  },
                  child: const Text('Get Letters by Date'),
                ),
                const Divider(height: 20),

                // Promises API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(promisesViewModelProvider.notifier)
                          .createPromise('미안해...');
                      print('Create promise result: $result');
                    } catch (e) {
                      print('Create promise error: $e');
                    }
                  },
                  child: const Text('Create Promise'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final promiseList = await ref
                          .read(promisesViewModelProvider.notifier)
                          .getPromises(0, 10);
                      print(
                          'Get promises result: ${promiseList.promiseList.map((e) => e.content).toList()}');
                    } catch (e) {
                      print('Get promises error: $e');
                    }
                  },
                  child: const Text('Get Promises'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final result = await ref
                          .read(promisesViewModelProvider.notifier)
                          .deletePromise(1);
                      print('Delete promise result: $result');
                    } catch (e) {
                      print('Delete promise error: $e');
                    }
                  },
                  child: const Text('Delete Promise'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final count = await ref
                          .read(promisesViewModelProvider.notifier)
                          .getPromiseCount();
                      print('Get promise count result: $count');
                    } catch (e) {
                      print('Get promise count error: $e');
                    }
                  },
                  child: const Text('Get Promise Count'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final promiseList = await ref
                          .read(promisesViewModelProvider.notifier)
                          .getPromisesByDate('2025-02-13', 0, 10);
                      print(
                          'Get promises by date result: ${promiseList.promiseList.map((e) => e.content).toList()}');
                    } catch (e) {
                      print('Get promises by date error: $e');
                    }
                  },
                  child: const Text('Get Promises by Date'),
                ),
                const Divider(height: 20),

                // Calendar API
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token');
                    if (token == null) {
                      print('No access token available. Please login first.');
                      return;
                    }
                    try {
                      final calendar = await ref
                          .read(calendarViewModelProvider.notifier)
                          .getCalendar(2025, 2);
                      print(
                          'Calendar letters: ${calendar.letters.map((e) => "${e.date}: ${e.count}").toList()}');
                      print(
                          'Calendar promises: ${calendar.promises.map((e) => "${e.date}: ${e.count}").toList()}');
                    } catch (e) {
                      print('Get calendar error: $e');
                    }
                  },
                  child: const Text('Get Calendar'),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
