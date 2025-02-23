// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LetterListResponse _$LetterListResponseFromJson(Map<String, dynamic> json) {
  return _LetterListResponse.fromJson(json);
}

/// @nodoc
mixin _$LetterListResponse {
  List<LetterResponse> get letterList => throw _privateConstructorUsedError;
  bool get isFirst => throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LetterListResponseCopyWith<LetterListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterListResponseCopyWith<$Res> {
  factory $LetterListResponseCopyWith(
          LetterListResponse value, $Res Function(LetterListResponse) then) =
      _$LetterListResponseCopyWithImpl<$Res, LetterListResponse>;
  @useResult
  $Res call(
      {List<LetterResponse> letterList,
      bool isFirst,
      bool isLast,
      bool hasNext});
}

/// @nodoc
class _$LetterListResponseCopyWithImpl<$Res, $Val extends LetterListResponse>
    implements $LetterListResponseCopyWith<$Res> {
  _$LetterListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letterList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_value.copyWith(
      letterList: null == letterList
          ? _value.letterList
          : letterList // ignore: cast_nullable_to_non_nullable
              as List<LetterResponse>,
      isFirst: null == isFirst
          ? _value.isFirst
          : isFirst // ignore: cast_nullable_to_non_nullable
              as bool,
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LetterListResponseImplCopyWith<$Res>
    implements $LetterListResponseCopyWith<$Res> {
  factory _$$LetterListResponseImplCopyWith(_$LetterListResponseImpl value,
          $Res Function(_$LetterListResponseImpl) then) =
      __$$LetterListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LetterResponse> letterList,
      bool isFirst,
      bool isLast,
      bool hasNext});
}

/// @nodoc
class __$$LetterListResponseImplCopyWithImpl<$Res>
    extends _$LetterListResponseCopyWithImpl<$Res, _$LetterListResponseImpl>
    implements _$$LetterListResponseImplCopyWith<$Res> {
  __$$LetterListResponseImplCopyWithImpl(_$LetterListResponseImpl _value,
      $Res Function(_$LetterListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letterList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_$LetterListResponseImpl(
      letterList: null == letterList
          ? _value._letterList
          : letterList // ignore: cast_nullable_to_non_nullable
              as List<LetterResponse>,
      isFirst: null == isFirst
          ? _value.isFirst
          : isFirst // ignore: cast_nullable_to_non_nullable
              as bool,
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LetterListResponseImpl implements _LetterListResponse {
  const _$LetterListResponseImpl(
      {required final List<LetterResponse> letterList,
      required this.isFirst,
      required this.isLast,
      required this.hasNext})
      : _letterList = letterList;

  factory _$LetterListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LetterListResponseImplFromJson(json);

  final List<LetterResponse> _letterList;
  @override
  List<LetterResponse> get letterList {
    if (_letterList is EqualUnmodifiableListView) return _letterList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_letterList);
  }

  @override
  final bool isFirst;
  @override
  final bool isLast;
  @override
  final bool hasNext;

  @override
  String toString() {
    return 'LetterListResponse(letterList: $letterList, isFirst: $isFirst, isLast: $isLast, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterListResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._letterList, _letterList) &&
            (identical(other.isFirst, isFirst) || other.isFirst == isFirst) &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_letterList),
      isFirst,
      isLast,
      hasNext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterListResponseImplCopyWith<_$LetterListResponseImpl> get copyWith =>
      __$$LetterListResponseImplCopyWithImpl<_$LetterListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LetterListResponseImplToJson(
      this,
    );
  }
}

abstract class _LetterListResponse implements LetterListResponse {
  const factory _LetterListResponse(
      {required final List<LetterResponse> letterList,
      required final bool isFirst,
      required final bool isLast,
      required final bool hasNext}) = _$LetterListResponseImpl;

  factory _LetterListResponse.fromJson(Map<String, dynamic> json) =
      _$LetterListResponseImpl.fromJson;

  @override
  List<LetterResponse> get letterList;
  @override
  bool get isFirst;
  @override
  bool get isLast;
  @override
  bool get hasNext;
  @override
  @JsonKey(ignore: true)
  _$$LetterListResponseImplCopyWith<_$LetterListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
