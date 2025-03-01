// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_email_code_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyEmailCodeRequest _$VerifyEmailCodeRequestFromJson(
    Map<String, dynamic> json) {
  return _VerifyEmailCodeRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyEmailCodeRequest {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyEmailCodeRequestCopyWith<VerifyEmailCodeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyEmailCodeRequestCopyWith<$Res> {
  factory $VerifyEmailCodeRequestCopyWith(VerifyEmailCodeRequest value,
          $Res Function(VerifyEmailCodeRequest) then) =
      _$VerifyEmailCodeRequestCopyWithImpl<$Res, VerifyEmailCodeRequest>;
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class _$VerifyEmailCodeRequestCopyWithImpl<$Res,
        $Val extends VerifyEmailCodeRequest>
    implements $VerifyEmailCodeRequestCopyWith<$Res> {
  _$VerifyEmailCodeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyEmailCodeRequestImplCopyWith<$Res>
    implements $VerifyEmailCodeRequestCopyWith<$Res> {
  factory _$$VerifyEmailCodeRequestImplCopyWith(
          _$VerifyEmailCodeRequestImpl value,
          $Res Function(_$VerifyEmailCodeRequestImpl) then) =
      __$$VerifyEmailCodeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class __$$VerifyEmailCodeRequestImplCopyWithImpl<$Res>
    extends _$VerifyEmailCodeRequestCopyWithImpl<$Res,
        _$VerifyEmailCodeRequestImpl>
    implements _$$VerifyEmailCodeRequestImplCopyWith<$Res> {
  __$$VerifyEmailCodeRequestImplCopyWithImpl(
      _$VerifyEmailCodeRequestImpl _value,
      $Res Function(_$VerifyEmailCodeRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_$VerifyEmailCodeRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyEmailCodeRequestImpl implements _VerifyEmailCodeRequest {
  const _$VerifyEmailCodeRequestImpl({required this.email, required this.code});

  factory _$VerifyEmailCodeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyEmailCodeRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String code;

  @override
  String toString() {
    return 'VerifyEmailCodeRequest(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailCodeRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailCodeRequestImplCopyWith<_$VerifyEmailCodeRequestImpl>
      get copyWith => __$$VerifyEmailCodeRequestImplCopyWithImpl<
          _$VerifyEmailCodeRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyEmailCodeRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyEmailCodeRequest implements VerifyEmailCodeRequest {
  const factory _VerifyEmailCodeRequest(
      {required final String email,
      required final String code}) = _$VerifyEmailCodeRequestImpl;

  factory _VerifyEmailCodeRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyEmailCodeRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$VerifyEmailCodeRequestImplCopyWith<_$VerifyEmailCodeRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
