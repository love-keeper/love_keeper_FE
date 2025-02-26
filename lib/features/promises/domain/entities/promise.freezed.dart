// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Promise {
  int get memberId => throw _privateConstructorUsedError;
  int get promiseId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get promisedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PromiseCopyWith<Promise> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromiseCopyWith<$Res> {
  factory $PromiseCopyWith(Promise value, $Res Function(Promise) then) =
      _$PromiseCopyWithImpl<$Res, Promise>;
  @useResult
  $Res call({int memberId, int promiseId, String content, String promisedAt});
}

/// @nodoc
class _$PromiseCopyWithImpl<$Res, $Val extends Promise>
    implements $PromiseCopyWith<$Res> {
  _$PromiseCopyWithImpl(this._value, this._then);

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
abstract class _$$PromiseImplCopyWith<$Res> implements $PromiseCopyWith<$Res> {
  factory _$$PromiseImplCopyWith(
          _$PromiseImpl value, $Res Function(_$PromiseImpl) then) =
      __$$PromiseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int memberId, int promiseId, String content, String promisedAt});
}

/// @nodoc
class __$$PromiseImplCopyWithImpl<$Res>
    extends _$PromiseCopyWithImpl<$Res, _$PromiseImpl>
    implements _$$PromiseImplCopyWith<$Res> {
  __$$PromiseImplCopyWithImpl(
      _$PromiseImpl _value, $Res Function(_$PromiseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? promiseId = null,
    Object? content = null,
    Object? promisedAt = null,
  }) {
    return _then(_$PromiseImpl(
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

class _$PromiseImpl implements _Promise {
  const _$PromiseImpl(
      {required this.memberId,
      required this.promiseId,
      required this.content,
      required this.promisedAt});

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
    return 'Promise(memberId: $memberId, promiseId: $promiseId, content: $content, promisedAt: $promisedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromiseImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.promiseId, promiseId) ||
                other.promiseId == promiseId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.promisedAt, promisedAt) ||
                other.promisedAt == promisedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, promiseId, content, promisedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromiseImplCopyWith<_$PromiseImpl> get copyWith =>
      __$$PromiseImplCopyWithImpl<_$PromiseImpl>(this, _$identity);
}

abstract class _Promise implements Promise {
  const factory _Promise(
      {required final int memberId,
      required final int promiseId,
      required final String content,
      required final String promisedAt}) = _$PromiseImpl;

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
  _$$PromiseImplCopyWith<_$PromiseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
