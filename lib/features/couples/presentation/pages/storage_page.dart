import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/letters/domain/entities/letter.dart';
import 'package:love_keeper/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'package:love_keeper/features/letters/presentation/widgets/letter_box_widget.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart'; // 수정된 임포트
import 'package:love_keeper/features/promises/presentation/widgets/promise_box_widget.dart';
import 'package:intl/intl.dart';

class StoragePage extends ConsumerStatefulWidget {
  final int initialTab; // 0: 편지, 1: 약속
  const StoragePage({super.key, this.initialTab = 0});

  @override
  ConsumerState<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends ConsumerState<StoragePage> {
  late int selectedIndex;

  List<Map<String, String>> promises = [
    {
      'title': '첫 번째 약속',
      'content': '약속 내용이 이곳에 표시됩니다.',
      'date': '2025. 02. 01.',
    },
    {'title': '두 번째 약속', 'content': '또 다른 약속의 내용입니다.', 'date': '2025. 02. 05.'},
  ];

  bool _isEditingPromise = false;
  final TextEditingController _promiseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTab;
    // MembersViewModel에서 이미 fetchMemberInfo가 호출되므로 추가 호출 불필요
  }

  void _submitPromise() {
    if (_promiseController.text.trim().isEmpty) return;
    final now = DateTime.now();
    String currentDate =
        "${now.year}. ${now.month.toString().padLeft(2, '0')}. ${now.day.toString().padLeft(2, '0')}.";
    setState(() {
      promises.insert(0, {
        'title': '새로운 약속',
        'content': _promiseController.text.trim(),
        'date': currentDate,
      });
      _promiseController.clear();
      _isEditingPromise = false;
    });
  }

  Widget _buildPromiseEditingBox() {
    return Container(
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
          hintText: '내용을 입력해 주세요.',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            height: 24 / 16,
            color: Color(0xFF747784),
          ),
        ),
        maxLines: null,
        onSubmitted: (value) {
          _submitPromise();
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _buildPromiseStorage() {
    List<Map<String, String>> sortedPromises = List.from(promises);
    sortedPromises.sort((a, b) {
      DateTime dateA = DateFormat(
        'yyyy. MM. dd.',
      ).parse(a['date'] ?? '1900. 01. 01.');
      DateTime dateB = DateFormat(
        'yyyy. MM. dd.',
      ).parse(b['date'] ?? '1900. 01. 01.');
      return dateB.compareTo(dateA);
    });
    int itemCount = sortedPromises.length + (_isEditingPromise ? 1 : 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 0),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          if (_isEditingPromise && index == 0) {
            return _buildPromiseEditingBox();
          }
          final int promiseIndex = _isEditingPromise ? index - 1 : index;
          final promise = sortedPromises[promiseIndex];
          return Dismissible(
            key: Key("promise_${promiseIndex}_${promise['date']}"),
            direction: DismissDirection.endToStart,
            background: Container(
              color: const Color(0xFFC3C6CF),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                promises.removeAt(promiseIndex);
              });
            },
            child: PromiseBoxWidget(
              content: promise['content'] ?? '',
              date: promise['date'] ?? '',
            ),
          );
        },
      ),
    );
  }

  Widget _buildLetterStorage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxWidth = (screenWidth - 55) / 2;
    final double boxHeight = boxWidth * (160 / 156);
    final lettersState = ref.watch(lettersViewModelProvider);
    final memberInfo = ref.watch(membersViewModelProvider).value; // 변경된 프로바이더

    return lettersState.when(
      data: (letterList) {
        if (letterList == null || letterList.letters.isEmpty) {
          return const Center(child: Text('편지가 없습니다.'));
        }
        final sortedLetters = List<Letter>.from(letterList.letters);
        sortedLetters.sort((a, b) {
          DateTime dateA = DateTime.parse(a.sentDate);
          DateTime dateB = DateTime.parse(b.sentDate);
          return dateB.compareTo(dateA); // 최신순 정렬
        });
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
    double barWidth = (screenWidth - 40) / 2; // 탭 바 너비 계산
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
              // "편지" 탭
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    _isEditingPromise = false;
                    _promiseController.clear();
                    print('Switched to Letters: $selectedIndex');
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
              // "약속" 탭
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    _isEditingPromise = false;
                    _promiseController.clear();
                    print('Switched to Promises: $selectedIndex');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
      'Build - selectedIndex: $selectedIndex, _isEditingPromise: $_isEditingPromise',
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Image.asset(
                'assets/images/storage_page/Ic_Calender.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                context.push('/calendar');
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 기존 body 내용
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
                const SizedBox(height: 130),
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
          // 조건문에 따라 버튼 배치
          if (selectedIndex == 1 && !_isEditingPromise)
            Positioned(
              bottom: 103, // 탭 바 위로 배치 (필요시 조정)
              right: 20, // 오른쪽 여백
              child: SizedBox(
                width: 56,
                height: 56,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isEditingPromise = true;
                    });
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
    );
  }
}
