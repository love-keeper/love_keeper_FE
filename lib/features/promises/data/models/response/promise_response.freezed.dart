// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promise_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PromiseResponse _$PromiseResponseFromJson(Map<String, dynamic> json) {
  return _PromiseResponse.fromJson(json);
}

/// @nodoc
mixin _$PromiseResponse {
  int get memberId => throw _privateConstructorUsedError;
  int get promiseId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get promisedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromiseResponseCopyWith<PromiseResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromiseResponseCopyWith<$Res> {
  factory $PromiseResponseCopyWith(
          PromiseResponse value, $Res Function(PromiseResponse) then) =
      _$PromiseResponseCopyWithImpl<$Res, PromiseResponse>;
  @useResult
  $Res call({int memberId, int promiseId, String content, String promisedAt});
}

/// @nodoc
class _$PromiseResponseCopyWithImpl<$Res, $Val extends PromiseResponse>
    implements $PromiseResponseCopyWith<$Res> {
  _$PromiseResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? promiseId = null,
    Object? content = null,
    Object? promisedAt = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      promiseId: null == promiseId
          ? _value.promiseId
          : promiseId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      promisedAt: null == promisedAt
          ? _value.promisedAt
          : promisedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromiseResponseImplCopyWith<$Res>
    implements $PromiseResponseCopyWith<$Res> {
  factory _$$PromiseResponseImplCopyWith(_$PromiseResponseImpl value,
          $Res Function(_$PromiseResponseImpl) then) =
      __$$PromiseResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int memberId, int promiseId, String content, String promisedAt});
}

/// @nodoc
class __$$PromiseResponseImplCopyWithImpl<$Res>
    extends _$PromiseResponseCopyWithImpl<$Res, _$PromiseResponseImpl>
    implements _$$PromiseResponseImplCopyWith<$Res> {
  __$$PromiseResponseImplCopyWithImpl(
      _$PromiseResponseImpl _value, $Res Function(_$PromiseResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? promiseId = null,
    Object? content = null,
    Object? promisedAt = null,
  }) {
    return _then(_$PromiseResponseImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      promiseId: null == promiseId
          ? _value.promiseId
          : promiseId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      promisedAt: null == promisedAt
          ? _value.promisedAt
          : promisedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromiseResponseImpl implements _PromiseResponse {
  const _$PromiseResponseImpl(
      {required this.memberId,
      required this.promiseId,
      required this.content,
      required this.promisedAt});

  factory _$PromiseResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromiseResponseImplFromJson(json);

  @override
  final int memberId;
  @override
  final int promiseId;
  @override
  final String content;
  @override
  final String promisedAt;

  @override
  String toString() {
    return 'PromiseResponse(memberId: $memberId, promiseId: $promiseId, content: $content, promisedAt: $promisedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromiseResponseImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.promiseId, promiseId) ||
                other.promiseId == promiseId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.promisedAt, promisedAt) ||
                other.promisedAt == promisedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, promiseId, content, promisedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromiseResponseImplCopyWith<_$PromiseResponseImpl> get copyWith =>
      __$$PromiseResponseImplCopyWithImpl<_$PromiseResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromiseResponseImplToJson(
      this,
    );
  }
}

abstract class _PromiseResponse implements PromiseResponse {
  const factory _PromiseResponse(
      {required final int memberId,
      required final int promiseId,
      required final String content,
      required final String promisedAt}) = _$PromiseResponseImpl;

  factory _PromiseResponse.fromJson(Map<String, dynamic> json) =
      _$PromiseResponseImpl.fromJson;

  @override
  int get memberId;
  @override
  int get promiseId;
  @override
  String get content;
  @override
  String get promisedAt;
  @override
  @JsonKey(ignore: true)
  _$$PromiseResponseImplCopyWith<_$PromiseResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
