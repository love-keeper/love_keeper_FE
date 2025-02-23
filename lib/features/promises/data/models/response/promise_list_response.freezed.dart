// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promise_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PromiseListResponse _$PromiseListResponseFromJson(Map<String, dynamic> json) {
  return _PromiseListResponse.fromJson(json);
}

/// @nodoc
mixin _$PromiseListResponse {
  List<PromiseResponse> get promiseList => throw _privateConstructorUsedError;
  bool get isFirst => throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromiseListResponseCopyWith<PromiseListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromiseListResponseCopyWith<$Res> {
  factory $PromiseListResponseCopyWith(
          PromiseListResponse value, $Res Function(PromiseListResponse) then) =
      _$PromiseListResponseCopyWithImpl<$Res, PromiseListResponse>;
  @useResult
  $Res call(
      {List<PromiseResponse> promiseList,
      bool isFirst,
      bool isLast,
      bool hasNext});
}

/// @nodoc
class _$PromiseListResponseCopyWithImpl<$Res, $Val extends PromiseListResponse>
    implements $PromiseListResponseCopyWith<$Res> {
  _$PromiseListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promiseList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_value.copyWith(
      promiseList: null == promiseList
          ? _value.promiseList
          : promiseList // ignore: cast_nullable_to_non_nullable
              as List<PromiseResponse>,
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
abstract class _$$PromiseListResponseImplCopyWith<$Res>
    implements $PromiseListResponseCopyWith<$Res> {
  factory _$$PromiseListResponseImplCopyWith(_$PromiseListResponseImpl value,
          $Res Function(_$PromiseListResponseImpl) then) =
      __$$PromiseListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PromiseResponse> promiseList,
      bool isFirst,
      bool isLast,
      bool hasNext});
}

/// @nodoc
class __$$PromiseListResponseImplCopyWithImpl<$Res>
    extends _$PromiseListResponseCopyWithImpl<$Res, _$PromiseListResponseImpl>
    implements _$$PromiseListResponseImplCopyWith<$Res> {
  __$$PromiseListResponseImplCopyWithImpl(_$PromiseListResponseImpl _value,
      $Res Function(_$PromiseListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promiseList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_$PromiseListResponseImpl(
      promiseList: null == promiseList
          ? _value._promiseList
          : promiseList // ignore: cast_nullable_to_non_nullable
              as List<PromiseResponse>,
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
class _$PromiseListResponseImpl implements _PromiseListResponse {
  const _$PromiseListResponseImpl(
      {required final List<PromiseResponse> promiseList,
      required this.isFirst,
      required this.isLast,
      required this.hasNext})
      : _promiseList = promiseList;

  factory _$PromiseListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromiseListResponseImplFromJson(json);

  final List<PromiseResponse> _promiseList;
  @override
  List<PromiseResponse> get promiseList {
    if (_promiseList is EqualUnmodifiableListView) return _promiseList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promiseList);
  }

  @override
  final bool isFirst;
  @override
  final bool isLast;
  @override
  final bool hasNext;

  @override
  String toString() {
    return 'PromiseListResponse(promiseList: $promiseList, isFirst: $isFirst, isLast: $isLast, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromiseListResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._promiseList, _promiseList) &&
            (identical(other.isFirst, isFirst) || other.isFirst == isFirst) &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_promiseList),
      isFirst,
      isLast,
      hasNext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromiseListResponseImplCopyWith<_$PromiseListResponseImpl> get copyWith =>
      __$$PromiseListResponseImplCopyWithImpl<_$PromiseListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromiseListResponseImplToJson(
      this,
    );
  }
}

abstract class _PromiseListResponse implements PromiseListResponse {
  const factory _PromiseListResponse(
      {required final List<PromiseResponse> promiseList,
      required final bool isFirst,
      required final bool isLast,
      required final bool hasNext}) = _$PromiseListResponseImpl;

  factory _PromiseListResponse.fromJson(Map<String, dynamic> json) =
      _$PromiseListResponseImpl.fromJson;

  @override
  List<PromiseResponse> get promiseList;
  @override
  bool get isFirst;
  @override
  bool get isLast;
  @override
  bool get hasNext;
  @override
  @JsonKey(ignore: true)
  _$$PromiseListResponseImplCopyWith<_$PromiseListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
