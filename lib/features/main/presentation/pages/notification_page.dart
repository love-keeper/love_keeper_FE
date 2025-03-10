import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:love_keeper/features/main/presentation/widgets/tab_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool _showNotifications = true;

  @override
  void initState() {
    super.initState();
    // 위젯 빌드가 완료된 후에 fetchNotifications 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fCMViewModelProvider.notifier).fetchNotifications();
    });

    // 무한 스크롤 설정
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        // 스크롤이 끝에 가까워지면 추가 데이터 로드
        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 200) {
          final state = ref.read(fCMViewModelProvider);
          if (!state.isLoadingMore && state.hasNext) {
            print('추가 데이터 로드 시도');
            ref
                .read(fCMViewModelProvider.notifier)
                .fetchNotifications(loadMore: true);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fcmState = ref.watch(fCMViewModelProvider);

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            fcmState.isLoading && fcmState.notifications.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : fcmState.error != null
                ? Center(child: Text(fcmState.error!))
                : !_showNotifications || fcmState.notifications.isEmpty
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
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  itemCount:
                      fcmState.notifications.length +
                      (fcmState.hasNext ? 1 : 0), // hasNext만 체크하도록 조건 변경
                  itemBuilder: (context, index) {
                    if (index == fcmState.notifications.length) {
                      // 로딩 표시기 개선
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(255, 157, 175, 1),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    final notification = fcmState.notifications[index];
                    final isRead = notification.read;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // 알림 클릭 시 읽음 처리
                            if (!isRead) {
                              ref
                                  .read(fCMViewModelProvider.notifier)
                                  .markAsRead(notification.id);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ), // 고정 높이 대신 패딩 사용
                            decoration: BoxDecoration(
                              color:
                                  isRead
                                      ? Colors.white
                                      : const Color.fromRGBO(255, 157, 175, 1),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  isRead
                                      ? Border.all(
                                        color: const Color(0xFFE0E0E0),
                                      )
                                      : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.4,
                                    color:
                                        isRead
                                            ? const Color(0xFF27282C)
                                            : Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  notification.relativeTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.45,
                                    color:
                                        isRead
                                            ? const Color(0xFF9E9E9E)
                                            : Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
