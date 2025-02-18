import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/main/widgets/tab_bar.dart';
import 'package:love_keeper_fe/features/main/widgets/letter_box_widget.dart';
import 'package:love_keeper_fe/features/main/widgets/promise_box_widget.dart';
import 'package:intl/intl.dart';

class StoragePage extends StatefulWidget {
  final int initialTab; // 0: 편지, 1: 약속
  const StoragePage({super.key, this.initialTab = 0});

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  late int selectedIndex;

  // 약속 탭의 초기 샘플 데이터
  List<Map<String, String>> promises = [
    {
      'title': '첫 번째 약속',
      'content': '약속 내용이 이곳에 표시됩니다. 자세한 내용은 생략될 수 있습니다.',
      'date': '2025. 02. 01.'
    },
    {
      'title': '두 번째 약속',
      'content': '또 다른 약속의 내용이 여기에 표시됩니다. 내용이 길 경우 ... 처리됩니다.',
      'date': '2025. 02. 05.'
    },
    {
      'title': '세 번째 약속',
      'content': '세 번째 약속 내용 예시입니다.',
      'date': '2025. 02. 10.'
    },
    {'title': '네 번째 약속', 'content': '네 번째 약속 내용입니다.', 'date': '2025. 02. 15.'},
  ];

  // 편지 탭의 샘플 데이터
  final List<Map<String, String>> letters = [
    {
      'user': '돌돌',
      'content': '내가 너무 심했던 것 같아 용서해 줄 수 있어? 다시해와 엊꺼ㅜ우',
      'date': '2025. 02. 01.'
    },
    {
      'user': '미미',
      'content': '예시 내용입니다. 이것은 긴 내용일 경우 생략됩니다. 어쩌라고',
      'date': '2025. 02. 02.'
    },
    {
      'user': '돌돌',
      'content': '세 번째 편지 내용이 이렇게 길게 들어갈 경우 테스트 합니다.',
      'date': '2025. 02. 03.'
    },
    {'user': '돌돌', 'content': '네 번째 편지 내용입니다.', 'date': '2025. 02. 04.'},
    {'user': '미미', 'content': '다섯 번째 편지 내용입니다.', 'date': '2025. 02. 05.'},
    {'user': '돌돌', 'content': '여섯 번째 편지 내용입니다.', 'date': '2025. 02. 06.'},
    {'user': '미미', 'content': '일곱 번째 편지 내용입니다.', 'date': '2025. 02. 07.'},
    {'user': '돌돌', 'content': '여덟 번째 편지 내용입니다.', 'date': '2025. 02. 08.'},
  ];

  // 약속 작성 상태와 텍스트 컨트롤러
  bool _isEditingPromise = false;
  final TextEditingController _promiseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTab;
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
      padding: const EdgeInsets.all(10),
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
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "내용을 입력해 주세요.",
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
    // promises 리스트를 복사 후, 날짜 기준 내림차순 정렬
    List<Map<String, String>> sortedPromises = List.from(promises);
    sortedPromises.sort((a, b) {
      DateTime dateA =
          DateFormat("yyyy. MM. dd.").parse(a['date'] ?? "1900. 01. 01.");
      DateTime dateB =
          DateFormat("yyyy. MM. dd.").parse(b['date'] ?? "1900. 01. 01.");
      return dateB.compareTo(dateA);
    });

    int itemCount = sortedPromises.length + (_isEditingPromise ? 1 : 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 83 + 15),
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
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                promises.removeAt(promiseIndex);
              });
            },
            child: PromiseBoxWidget(
              content: promise['content'] ?? "",
              date: promise['date'] ?? "",
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

    // letters 리스트를 복사한 후, 날짜 기준 내림차순(최근 날짜가 위로) 정렬
    List<Map<String, String>> sortedLetters = List.from(letters);
    sortedLetters.sort((a, b) {
      // 날짜 형식: "yyyy. MM. dd." (끝에 점이 있는 형식)
      DateTime dateA =
          DateFormat("yyyy. MM. dd.").parse(a['date'] ?? "1900. 01. 01.");
      DateTime dateB =
          DateFormat("yyyy. MM. dd.").parse(b['date'] ?? "1900. 01. 01.");
      return dateB.compareTo(dateA);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 83 + 15),
        itemCount: sortedLetters.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: boxWidth / boxHeight,
        ),
        itemBuilder: (context, index) {
          final letter = sortedLetters[index];
          return LetterBoxWidget(
            title: '${letter['user']}의 편지',
            content: letter['content'] ?? "",
            date: letter['date'] ?? "",
          );
        },
      ),
    );
  }

  Widget _buildCustomTabBar() {
    double screenWidth = MediaQuery.of(context).size.width;
    double barWidth = (screenWidth - 40) / 2;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (TapDownDetails details) {
        double tapX = details.globalPosition.dx - 20;
        setState(() {
          selectedIndex = tapX < barWidth ? 0 : 1;
          if (selectedIndex == 0) {
            _isEditingPromise = false;
            _promiseController.clear();
          }
        });
      },
      child: Column(
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                        _isEditingPromise = false;
                        _promiseController.clear();
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      width: barWidth,
                      child: Center(
                        child: Text(
                          '편지',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            fontWeight: FontWeight.w400,
                            color: selectedIndex == 0
                                ? const Color(0xFFFF859B)
                                : const Color(0xFFAFB2BF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                        _isEditingPromise = false;
                        _promiseController.clear();
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      width: barWidth,
                      child: Center(
                        child: Text(
                          '약속',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            fontWeight: FontWeight.w400,
                            color: selectedIndex == 1
                                ? const Color(0xFFFF859B)
                                : const Color(0xFFAFB2BF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promiseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      floatingActionButton: (selectedIndex == 1 && !_isEditingPromise)
          ? SizedBox(
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
            )
          : null,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF27282C),
          ),
        ),
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
      body: Container(
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
              child: selectedIndex == 0
                  ? _buildLetterStorage()
                  : _buildPromiseStorage(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabBarWidget(
        currentIndex: 1,
        onTabSelected: (index) {
          if (index == 1) return;
          if (index == 0) {
            context.pop();
          } else if (index == 2) {
            context.pushReplacement('/main?initialIndex=2');
          }
        },
      ),
    );
  }
}
