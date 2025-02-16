import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required String timestamp,
    required String code,
    required String message,
    T? result,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

// void 타입을 위한 JsonConverter
class VoidConverter implements JsonConverter<void, Object?> {
  const VoidConverter();

  @override
  void fromJson(Object? _) {}

  @override
  Object? toJson(void _) => null;
}
