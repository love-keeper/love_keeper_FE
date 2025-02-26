import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_birthday_request.freezed.dart';
part 'update_birthday_request.g.dart';

@freezed
class UpdateBirthdayRequest with _$UpdateBirthdayRequest {
  const factory UpdateBirthdayRequest({
    required String birthday,
  }) = _UpdateBirthdayRequest;

  factory UpdateBirthdayRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBirthdayRequestFromJson(json);
}
