import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_start_date_request.freezed.dart';
part 'update_start_date_request.g.dart';

@freezed
class UpdateStartDateRequest with _$UpdateStartDateRequest {
  const factory UpdateStartDateRequest({
    required String newStartDate,
  }) = _UpdateStartDateRequest;

  factory UpdateStartDateRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStartDateRequestFromJson(json);
}
