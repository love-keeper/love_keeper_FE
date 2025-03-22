import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:love_keeper/features/letters/domain/entities/letter.dart';
import 'package:love_keeper/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'package:love_keeper/features/letters/presentation/widgets/letter_box_widget.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/promises/domain/entities/promise.dart';
import 'package:love_keeper/features/promises/presentation/viewmodels/promises_viewmodel.dart';
import 'package:love_keeper/features/promises/presentation/widgets/promise_box_widget.dart';

class DetailPage extends ConsumerStatefulWidget {
  final DateTime selectedDay;
  final String type; // "letter" 또는 "promise"

  const DetailPage({super.key, required this.selectedDay, required this.type});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  List<Letter> _letters = [];
  List<Promise> _promises = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future(() async {
      final dateStr = DateFormat('yyyy-MM-dd').format(widget.selectedDay);
      if (widget.type == 'letter') {
        final result = await ref
            .read(lettersViewModelProvider.notifier)
            .getLettersByDate(dateStr, 0, 100);
        setState(() {
          _letters = result.letters;
          _isLoading = false;
        });
      } else {
        final result = await ref
            .read(promisesViewModelProvider.notifier)
            .getPromisesByDate(dateStr, 0, 100);
        setState(() {
          _promises = result.promiseList;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxWidth = (screenWidth - 55) / 2;
    final double boxHeight = boxWidth * (160 / 156);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '${widget.selectedDay.month}월 ${widget.selectedDay.day}일',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45,
            color: Color(0xFF27282C),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/storage_page/Img_ArchivedCalender_BG.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : widget.type == 'letter'
                ? _letters.isEmpty
                    ? const Center(child: Text('해당 날짜에 편지가 없습니다.'))
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 140, bottom: 20),
                        itemCount: _letters.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: boxWidth / boxHeight,
                        ),
                        itemBuilder: (context, index) {
                          final letter = _letters[index];
                          final memberInfo =
                              ref.read(membersViewModelProvider).value;
                          final myNickname = memberInfo?.nickname ?? '나';
                          final partnerNickname =
                              memberInfo?.coupleNickname ?? '상대방';
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
                    )
                : _promises.isEmpty
                ? const Center(child: Text('해당 날짜에 약속이 없습니다.'))
                : ListView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 140),
                  itemCount: _promises.length,
                  itemBuilder: (context, index) {
                    final promise = _promises[index];
                    final formattedDate = DateFormat(
                      'yyyy. MM. dd.',
                    ).format(DateTime.parse(promise.promisedAt));
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: PromiseBoxWidget(
                        content: promise.content,
                        date: formattedDate,
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
