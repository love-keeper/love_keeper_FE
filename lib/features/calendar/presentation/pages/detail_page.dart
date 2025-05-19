import 'dart:ui';

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
  final String type;

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
            .getLettersByDate(widget.selectedDay, 0, 100);
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
    final boxWidth = (screenWidth - 55) / 2;
    final boxHeight = boxWidth * (160 / 156);
    final topPadding = MediaQuery.of(context).padding.top - 20;
    final double autoGap = topPadding; // AppBar 높이 고려

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.0), // 살짝 흐림 효과
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
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
          ),
        ),
      ),

      body: ScrollConfiguration(
        behavior: const NoGlowScrollBehavior(),
        child: Container(
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
                  : Padding(
                    padding: EdgeInsets.only(
                      top: autoGap,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    child:
                        widget.type == 'letter'
                            ? _letters.isEmpty
                                ? const Center(child: Text('해당 날짜에 편지가 없습니다.'))
                                : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _letters.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: boxWidth / boxHeight,
                                      ),
                                  itemBuilder: (context, index) {
                                    final letter = _letters[index];
                                    final memberInfo =
                                        ref
                                            .read(membersViewModelProvider)
                                            .value;
                                    final myNickname =
                                        memberInfo?.nickname ?? '나';
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
                                )
                            : _promises.isEmpty
                            ? const Center(child: Text('해당 날짜에 약속이 없습니다.'))
                            : ListView.builder(
                              physics: const BouncingScrollPhysics(),
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
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
