// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_duplication_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmailDuplicationRequest _$EmailDuplicationRequestFromJson(
    Map<String, dynamic> json) {
  return _EmailDuplicationRequest.fromJson(json);
}

/// @nodoc
mixin _$EmailDuplicationRequest {
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailDuplicationRequestCopyWith<EmailDuplicationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailDuplicationRequestCopyWith<$Res> {
  factory $EmailDuplicationRequestCopyWith(EmailDuplicationRequest value,
          $Res Function(EmailDuplicationRequest) then) =
      _$EmailDuplicationRequestCopyWithImpl<$Res, EmailDuplicationRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$EmailDuplicationRequestCopyWithImpl<$Res,
        $Val extends EmailDuplicationRequest>
    implements $EmailDuplicationRequestCopyWith<$Res> {
  _$EmailDuplicationRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$EmailDuplicationRequestImplCopyWith<$Res>
    implements $EmailDuplicationRequestCopyWith<$Res> {
  factory _$$EmailDuplicationRequestImplCopyWith(
          _$EmailDuplicationRequestImpl value,
          $Res Function(_$EmailDuplicationRequestImpl) then) =
      __$$EmailDuplicationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailDuplicationRequestImplCopyWithImpl<$Res>
    extends _$EmailDuplicationRequestCopyWithImpl<$Res,
        _$EmailDuplicationRequestImpl>
    implements _$$EmailDuplicationRequestImplCopyWith<$Res> {
  __$$EmailDuplicationRequestImplCopyWithImpl(
      _$EmailDuplicationRequestImpl _value,
      $Res Function(_$EmailDuplicationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailDuplicationRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailDuplicationRequestImpl implements _EmailDuplicationRequest {
  const _$EmailDuplicationRequestImpl({required this.email});

  factory _$EmailDuplicationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailDuplicationRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'EmailDuplicationRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailDuplicationRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailDuplicationRequestImplCopyWith<_$EmailDuplicationRequestImpl>
      get copyWith => __$$EmailDuplicationRequestImplCopyWithImpl<
          _$EmailDuplicationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailDuplicationRequestImplToJson(
      this,
    );
  }
}

abstract class _EmailDuplicationRequest implements EmailDuplicationRequest {
  const factory _EmailDuplicationRequest({required final String email}) =
      _$EmailDuplicationRequestImpl;

  factory _EmailDuplicationRequest.fromJson(Map<String, dynamic> json) =
      _$EmailDuplicationRequestImpl.fromJson;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$EmailDuplicationRequestImplCopyWith<_$EmailDuplicationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
