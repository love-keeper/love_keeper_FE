import 'package:freezed_annotation/freezed_annotation.dart';

part 'promise.freezed.dart';

@freezed
class Promise with _$Promise {
  const factory Promise({
    required int memberId,
    required int promiseId,
    required String content,
    required String promisedAt,
  }) = _Promise;
}
