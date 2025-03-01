// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_email_code_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendEmailCodeRequest _$SendEmailCodeRequestFromJson(Map<String, dynamic> json) {
  return _SendEmailCodeRequest.fromJson(json);
}

/// @nodoc
mixin _$SendEmailCodeRequest {
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendEmailCodeRequestCopyWith<SendEmailCodeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendEmailCodeRequestCopyWith<$Res> {
  factory $SendEmailCodeRequestCopyWith(SendEmailCodeRequest value,
          $Res Function(SendEmailCodeRequest) then) =
      _$SendEmailCodeRequestCopyWithImpl<$Res, SendEmailCodeRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$SendEmailCodeRequestCopyWithImpl<$Res,
        $Val extends SendEmailCodeRequest>
    implements $SendEmailCodeRequestCopyWith<$Res> {
  _$SendEmailCodeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendEmailCodeRequestImplCopyWith<$Res>
    implements $SendEmailCodeRequestCopyWith<$Res> {
  factory _$$SendEmailCodeRequestImplCopyWith(_$SendEmailCodeRequestImpl value,
          $Res Function(_$SendEmailCodeRequestImpl) then) =
      __$$SendEmailCodeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$SendEmailCodeRequestImplCopyWithImpl<$Res>
    extends _$SendEmailCodeRequestCopyWithImpl<$Res, _$SendEmailCodeRequestImpl>
    implements _$$SendEmailCodeRequestImplCopyWith<$Res> {
  __$$SendEmailCodeRequestImplCopyWithImpl(_$SendEmailCodeRequestImpl _value,
      $Res Function(_$SendEmailCodeRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$SendEmailCodeRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendEmailCodeRequestImpl implements _SendEmailCodeRequest {
  const _$SendEmailCodeRequestImpl({required this.email});

  factory _$SendEmailCodeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendEmailCodeRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'SendEmailCodeRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendEmailCodeRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendEmailCodeRequestImplCopyWith<_$SendEmailCodeRequestImpl>
      get copyWith =>
          __$$SendEmailCodeRequestImplCopyWithImpl<_$SendEmailCodeRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendEmailCodeRequestImplToJson(
      this,
    );
  }
}

abstract class _SendEmailCodeRequest implements SendEmailCodeRequest {
  const factory _SendEmailCodeRequest({required final String email}) =
      _$SendEmailCodeRequestImpl;

  factory _SendEmailCodeRequest.fromJson(Map<String, dynamic> json) =
      _$SendEmailCodeRequestImpl.fromJson;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$SendEmailCodeRequestImplCopyWith<_$SendEmailCodeRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
