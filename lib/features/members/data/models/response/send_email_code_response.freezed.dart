// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_email_code_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendEmailCodeResponse _$SendEmailCodeResponseFromJson(
    Map<String, dynamic> json) {
  return _SendEmailCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$SendEmailCodeResponse {
  String get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendEmailCodeResponseCopyWith<SendEmailCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendEmailCodeResponseCopyWith<$Res> {
  factory $SendEmailCodeResponseCopyWith(SendEmailCodeResponse value,
          $Res Function(SendEmailCodeResponse) then) =
      _$SendEmailCodeResponseCopyWithImpl<$Res, SendEmailCodeResponse>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class _$SendEmailCodeResponseCopyWithImpl<$Res,
        $Val extends SendEmailCodeResponse>
    implements $SendEmailCodeResponseCopyWith<$Res> {
  _$SendEmailCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendEmailCodeResponseImplCopyWith<$Res>
    implements $SendEmailCodeResponseCopyWith<$Res> {
  factory _$$SendEmailCodeResponseImplCopyWith(
          _$SendEmailCodeResponseImpl value,
          $Res Function(_$SendEmailCodeResponseImpl) then) =
      __$$SendEmailCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$SendEmailCodeResponseImplCopyWithImpl<$Res>
    extends _$SendEmailCodeResponseCopyWithImpl<$Res,
        _$SendEmailCodeResponseImpl>
    implements _$$SendEmailCodeResponseImplCopyWith<$Res> {
  __$$SendEmailCodeResponseImplCopyWithImpl(_$SendEmailCodeResponseImpl _value,
      $Res Function(_$SendEmailCodeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$SendEmailCodeResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendEmailCodeResponseImpl implements _SendEmailCodeResponse {
  const _$SendEmailCodeResponseImpl({required this.code});

  factory _$SendEmailCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendEmailCodeResponseImplFromJson(json);

  @override
  final String code;

  @override
  String toString() {
    return 'SendEmailCodeResponse(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendEmailCodeResponseImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendEmailCodeResponseImplCopyWith<_$SendEmailCodeResponseImpl>
      get copyWith => __$$SendEmailCodeResponseImplCopyWithImpl<
          _$SendEmailCodeResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendEmailCodeResponseImplToJson(
      this,
    );
  }
}

abstract class _SendEmailCodeResponse implements SendEmailCodeResponse {
  const factory _SendEmailCodeResponse({required final String code}) =
      _$SendEmailCodeResponseImpl;

  factory _SendEmailCodeResponse.fromJson(Map<String, dynamic> json) =
      _$SendEmailCodeResponseImpl.fromJson;

  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$SendEmailCodeResponseImplCopyWith<_$SendEmailCodeResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
