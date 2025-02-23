import 'package:freezed_annotation/freezed_annotation.dart';
import 'promise.dart';

part 'promise_list.freezed.dart';

@freezed
class PromiseList with _$PromiseList {
  const factory PromiseList({
    required List<Promise> promiseList,
    required bool isFirst,
    required bool isLast,
    required bool hasNext,
  }) = _PromiseList;
}
