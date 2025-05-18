import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/letters/domain/entities/letter.dart';
import 'package:love_keeper/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'package:love_keeper/features/letters/presentation/widgets/letter_box_widget.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/promises/domain/entities/promise_list.dart';
import 'package:love_keeper/features/promises/presentation/viewmodels/promises_viewmodel.dart';
import 'package:love_keeper/features/promises/presentation/widgets/promise_box_widget.dart';
import 'package:intl/intl.dart';

class StoragePage extends ConsumerStatefulWidget {
  final int initialTab;
  const StoragePage({super.key, this.initialTab = 0});

  static StoragePage fromState(GoRouterState state) {
    final tab =
        int.tryParse(state.uri.queryParameters['initialTab'] ?? '') ?? 0;
    return StoragePage(initialTab: tab);
  }

  @override
  ConsumerState<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends ConsumerState<StoragePage> {
  late int selectedIndex;
  bool _isEditingPromise = false;
  final TextEditingController _promiseController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _letterScrollController = ScrollController();
  int _letterPage = 0;
  final int _letterSize = 20;
  bool _isFetchingLetters = false;
  bool _letterHasNext = true;
  bool _isFetchingPromises = false; // 약속 페칭 상태 추가
  bool _promiseHasNext = true; // 약속 다음 페이지 여부 추가

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTab;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isFetchingPromises &&
          _promiseHasNext) {
        _isFetchingPromises = true;
        ref.read(promisesViewModelProvider.notifier).fetchMore().then((_) {
          final state = ref.read(promisesViewModelProvider);
          state.whenData((data) => _promiseHasNext = data?.hasNext ?? false);
          _isFetchingPromises = false;
        });
      }
    });

    _letterScrollController.addListener(() async {
      if (_letterScrollController.position.pixels >=
              _letterScrollController.position.maxScrollExtent - 100 &&
          !_isFetchingLetters &&
          _letterHasNext) {
        _isFetchingLetters = true;
        _letterPage++;
        final newList = await ref
            .read(lettersViewModelProvider.notifier)
            .getLetterList(_letterPage, _letterSize);
        _letterHasNext = newList.hasNext;
        _isFetchingLetters = false;
      }
    });
  }

  void _loadInitialData() {
    if (selectedIndex == 1) {
      _promiseHasNext = true;
      _isFetchingPromises = false;
      ref.read(promisesViewModelProvider.notifier).fetchInitial();
    } else {
      _letterPage = 0;
      _letterHasNext = true;
      _isFetchingLetters = false;
      ref.read(lettersViewModelProvider.notifier).fetchInitialLetters();
    }
  }

  void _submitPromise() async {
    if (_promiseController.text.trim().isEmpty) return;
    try {
      await ref
          .read(promisesViewModelProvider.notifier)
          .createPromise(_promiseController.text.trim());
      setState(() {
        _promiseController.clear();
        _isEditingPromise = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('약속 추가 실패: $e')));
    }
  }

  Widget _buildPromiseEditingBox() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 112,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: _promiseController,
          autofocus: true,
          maxLength: 35, // ✅ 40자 입력 제한

          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            height: 24 / 16,
            color: Color(0xFF27282C),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '', // ✅ 길이 카운터 안 보이게
            hintText: '내용을 입력해 주세요',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
              height: 24 / 16,
              color: Color(0xFF747784),
            ),
          ),
          maxLines: null,
          onSubmitted: (value) => _submitPromise(),
        ),
      ),
    );
  }

  Widget _buildPromiseStorage() {
    final promisesState = ref.watch(promisesViewModelProvider);
    return promisesState.when(
      data: (data) {
        final promises = data?.promiseList ?? [];
        final sortedPromises = List.from(promises)..sort((a, b) {
          final dateCompare = DateTime.parse(
            b.promisedAt,
          ).compareTo(DateTime.parse(a.promisedAt));
          if (dateCompare != 0) return dateCompare;
          return b.promiseId.compareTo(a.promiseId);
        });

        final hasNext = data?.hasNext ?? false;
        final itemCount =
            sortedPromises.length +
            (_isEditingPromise || sortedPromises.isEmpty ? 1 : 0) +
            (hasNext ? 1 : 0);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: itemCount,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    if (_isEditingPromise && index == 0) {
                      return _buildPromiseEditingBox();
                    }
                    if (sortedPromises.isEmpty && index == 0) {
                      return Column(
                        children: [
                          _buildPromiseEditingBox(),
                          const SizedBox(height: 10),
                          const Text(
                            '플러스 버튼을 눌러 우리만의 약속을 추가해 보세요\n추가한 약속은 왼쪽으로 스와이프하면 삭제할 수 있어요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: -0.4,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF747784),
                            ),
                          ),
                        ],
                      );
                    }
                    final promiseIndex = _isEditingPromise ? index - 1 : index;
                    if (promiseIndex >= sortedPromises.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final promise = sortedPromises[promiseIndex];
                    return Dismissible(
                      key: Key(promise.promiseId.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: const Color(0xFFC3C6CF),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) async {
                        try {
                          await ref
                              .read(promisesViewModelProvider.notifier)
                              .deletePromise(promise.promiseId);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('약속 삭제 실패: $e')),
                          );
                        }
                      },
                      child: PromiseBoxWidget(
                        content: promise.content,
                        date: DateFormat(
                          'yyyy. MM. dd.',
                        ).format(DateTime.parse(promise.promisedAt)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('오류: $error')),
    );
  }

  Widget _buildLetterStorage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxWidth = (screenWidth - 55) / 2;
    final double boxHeight = boxWidth * (160 / 156);
    final lettersState = ref.watch(lettersViewModelProvider);
    final memberInfo = ref.watch(membersViewModelProvider).value;

    return lettersState.when(
      data: (letterList) {
        if (letterList == null || letterList.letters.isEmpty) {
          return const Center(child: Text('편지가 없습니다.'));
        }
        final sortedLetters = List<Letter>.from(letterList.letters)..sort(
          (a, b) =>
              DateTime.parse(b.sentDate).compareTo(DateTime.parse(a.sentDate)),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemCount: sortedLetters.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: boxWidth / boxHeight,
            ),
            itemBuilder: (context, index) {
              final letter = sortedLetters[index];
              final myNickname = memberInfo?.nickname ?? '나';
              final partnerNickname = memberInfo?.coupleNickname ?? '상대방';
              final title =
                  letter.senderNickname == myNickname
                      ? '$myNickname의 편지'
                      : '$partnerNickname의 편지';
              final formattedDate = DateFormat(
                'yyyy. MM. dd.',
              ).format(DateTime.parse(letter.sentDate));
              return LetterBoxWidget(
                title: title,
                content: letter.content,
                date: formattedDate,
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('오류: $error')),
    );
  }

  Widget _buildCustomTabBar() {
    double screenWidth = MediaQuery.of(context).size.width;
    double barWidth = (screenWidth - 40) / 2;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFC3C6CF),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                left: selectedIndex == 0 ? 0 : barWidth,
                child: Container(
                  width: barWidth,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF859B),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    _isEditingPromise = false;
                    _promiseController.clear();
                    _loadInitialData(); // 편지 탭으로 전환 시 초기화
                  });
                },
                child: SizedBox(
                  width: barWidth,
                  child: Center(
                    child: Text(
                      '편지',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        fontWeight: FontWeight.w400,
                        color:
                            selectedIndex == 0
                                ? const Color(0xFFFF859B)
                                : const Color(0xFFAFB2BF),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    _isEditingPromise = false;
                    _promiseController.clear();
                    _loadInitialData(); // 약속 탭으로 전환 시 초기화
                  });
                },
                child: SizedBox(
                  width: barWidth,
                  child: Center(
                    child: Text(
                      '약속',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        fontWeight: FontWeight.w400,
                        color:
                            selectedIndex == 1
                                ? const Color(0xFFFF859B)
                                : const Color(0xFFAFB2BF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _promiseController.dispose();
    _scrollController.dispose();
    _letterScrollController.dispose();
    super.dispose();
  }

  // 캘린더 페이지로 이동 후 돌아올 때 호출
  Future<void> _navigateToCalendar() async {
    await context.push('/calendar');
    // 디테일 페이지에서 돌아오면 데이터 초기화
    _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double topPadding = mediaQuery.padding.top;
    final double deviceHeight = mediaQuery.size.height;
    final double deviceWidth = mediaQuery.size.width;

    final double toolbarHeight = topPadding + 44; // 기본 높이 + SafeArea
    final double safeGap = topPadding + 70;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      backgroundColor: Colors.white,
      // AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(toolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: toolbarHeight,
          title: const Text(''),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/storage_page/Ic_Calender.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: _navigateToCalendar,
              ),
            ),
          ],
        ),
      ),

      body: GestureDetector(
        onTap: () {
          if (_isEditingPromise) {
            setState(() {
              _isEditingPromise = false;
              _promiseController.clear();
              FocusScope.of(context).unfocus();
            });
          }
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 231, 235, 0.4),
                    Color.fromRGBO(255, 206, 215, 0.4),
                  ],
                  begin: FractionalOffset(0.12, 0.0),
                  end: FractionalOffset(0.88, 1.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: safeGap),
                  _buildCustomTabBar(),
                  const SizedBox(height: 30),
                  Expanded(
                    child:
                        selectedIndex == 0
                            ? _buildLetterStorage()
                            : _buildPromiseStorage(),
                  ),
                  const SizedBox(height: 95),
                ],
              ),
            ),
            if (selectedIndex == 1 && !_isEditingPromise)
              Positioned(
                bottom: 103,
                right: 20,
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() => _isEditingPromise = true);
                    },
                    backgroundColor: const Color(0xFFFF859B),
                    elevation: 0,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
