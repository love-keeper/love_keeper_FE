import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true) // 제네릭 지원 활성화
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required String timestamp,
    required String code,
    required String message,
    T? result,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
