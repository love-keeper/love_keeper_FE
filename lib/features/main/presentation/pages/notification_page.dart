import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/tab_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> _defaultNotifications = [
    {'message': '미미님으로부터 편지가 도착했어요.', 'time': '방금 전', 'isRead': false},
    {'message': '미미님으로부터 편지가 도착했어요.', 'time': '1분 전', 'isRead': false},
    {'message': '돌돌님으로부터 쪽지가 도착했어요.', 'time': '59분 전', 'isRead': true},
  ];

  List<Map<String, dynamic>> notifications = [];

  int _currentIndex = 0;
  bool _showNotifications = true;

  void _onTabSelected(int index) {
    if (index == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
      notifications =
          _showNotifications ? List.from(_defaultNotifications) : [];
    });
  }

  @override
  void initState() {
    super.initState();
    notifications = List.from(_defaultNotifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        title: const Text(
          '알림',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45,
            color: Color(0xFF27282C),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF27282C),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          Switch(
            value: _showNotifications,
            onChanged: (value) => _toggleNotifications(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/main_page/grey_logo.png',
                      width: 127,
                      height: 102,
                    ),
                    const SizedBox(height: 31),
                    const Text(
                      '새로운 알림이 없어요.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFAFB2BF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  final isRead = notification['isRead'] as bool;

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 7, left: 16),
                        height: 57,
                        decoration: BoxDecoration(
                          color: isRead
                              ? Colors.white
                              : const Color.fromRGBO(255, 157, 175, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification['message'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4,
                                color: isRead
                                    ? const Color(0xFF27282C)
                                    : Colors.white,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              notification['time'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.45,
                                color: isRead
                                    ? const Color(0xFF9E9E9E)
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  );
                },
              ),
      ),
      bottomNavigationBar: TabBarWidget(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
