// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_code_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyCodeRequest _$VerifyCodeRequestFromJson(Map<String, dynamic> json) {
  return _VerifyCodeRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyCodeRequest {
  String get email => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyCodeRequestCopyWith<VerifyCodeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyCodeRequestCopyWith<$Res> {
  factory $VerifyCodeRequestCopyWith(
          VerifyCodeRequest value, $Res Function(VerifyCodeRequest) then) =
      _$VerifyCodeRequestCopyWithImpl<$Res, VerifyCodeRequest>;
  @useResult
  $Res call({String email, int code});
}

/// @nodoc
class _$VerifyCodeRequestCopyWithImpl<$Res, $Val extends VerifyCodeRequest>
    implements $VerifyCodeRequestCopyWith<$Res> {
  _$VerifyCodeRequestCopyWithImpl(this._value, this._then);

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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyCodeRequestImplCopyWith<$Res>
    implements $VerifyCodeRequestCopyWith<$Res> {
  factory _$$VerifyCodeRequestImplCopyWith(_$VerifyCodeRequestImpl value,
          $Res Function(_$VerifyCodeRequestImpl) then) =
      __$$VerifyCodeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, int code});
}

/// @nodoc
class __$$VerifyCodeRequestImplCopyWithImpl<$Res>
    extends _$VerifyCodeRequestCopyWithImpl<$Res, _$VerifyCodeRequestImpl>
    implements _$$VerifyCodeRequestImplCopyWith<$Res> {
  __$$VerifyCodeRequestImplCopyWithImpl(_$VerifyCodeRequestImpl _value,
      $Res Function(_$VerifyCodeRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_$VerifyCodeRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyCodeRequestImpl implements _VerifyCodeRequest {
  const _$VerifyCodeRequestImpl({required this.email, required this.code});

  factory _$VerifyCodeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyCodeRequestImplFromJson(json);

  @override
  final String email;
  @override
  final int code;

  @override
  String toString() {
    return 'VerifyCodeRequest(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyCodeRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyCodeRequestImplCopyWith<_$VerifyCodeRequestImpl> get copyWith =>
      __$$VerifyCodeRequestImplCopyWithImpl<_$VerifyCodeRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyCodeRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyCodeRequest implements VerifyCodeRequest {
  const factory _VerifyCodeRequest(
      {required final String email,
      required final int code}) = _$VerifyCodeRequestImpl;

  factory _VerifyCodeRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyCodeRequestImpl.fromJson;

  @override
  String get email;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  _$$VerifyCodeRequestImplCopyWith<_$VerifyCodeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
