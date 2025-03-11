import 'package:freezed_annotation/freezed_annotation.dart';

part 'promise.freezed.dart';
part 'promise.g.dart'; // JSON 직렬화를 위한 파일

@freezed
class Promise with _$Promise {
  const factory Promise({
    required int memberId,
    required int promiseId,
    required String content,
    required String promisedAt,
  }) = _Promise;

  factory Promise.fromJson(Map<String, dynamic> json) =>
      _$PromiseFromJson(json);
}
