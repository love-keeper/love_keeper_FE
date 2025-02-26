// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promise_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PromiseList {
  List<Promise> get promiseList => throw _privateConstructorUsedError;
  bool get isFirst => throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PromiseListCopyWith<PromiseList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromiseListCopyWith<$Res> {
  factory $PromiseListCopyWith(
          PromiseList value, $Res Function(PromiseList) then) =
      _$PromiseListCopyWithImpl<$Res, PromiseList>;
  @useResult
  $Res call(
      {List<Promise> promiseList, bool isFirst, bool isLast, bool hasNext});
}

/// @nodoc
class _$PromiseListCopyWithImpl<$Res, $Val extends PromiseList>
    implements $PromiseListCopyWith<$Res> {
  _$PromiseListCopyWithImpl(this._value, this._then);

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
              as List<Promise>,
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
abstract class _$$PromiseListImplCopyWith<$Res>
    implements $PromiseListCopyWith<$Res> {
  factory _$$PromiseListImplCopyWith(
          _$PromiseListImpl value, $Res Function(_$PromiseListImpl) then) =
      __$$PromiseListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Promise> promiseList, bool isFirst, bool isLast, bool hasNext});
}

/// @nodoc
class __$$PromiseListImplCopyWithImpl<$Res>
    extends _$PromiseListCopyWithImpl<$Res, _$PromiseListImpl>
    implements _$$PromiseListImplCopyWith<$Res> {
  __$$PromiseListImplCopyWithImpl(
      _$PromiseListImpl _value, $Res Function(_$PromiseListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promiseList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_$PromiseListImpl(
      promiseList: null == promiseList
          ? _value._promiseList
          : promiseList // ignore: cast_nullable_to_non_nullable
              as List<Promise>,
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

class _$PromiseListImpl implements _PromiseList {
  const _$PromiseListImpl(
      {required final List<Promise> promiseList,
      required this.isFirst,
      required this.isLast,
      required this.hasNext})
      : _promiseList = promiseList;

  final List<Promise> _promiseList;
  @override
  List<Promise> get promiseList {
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
    return 'PromiseList(promiseList: $promiseList, isFirst: $isFirst, isLast: $isLast, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromiseListImpl &&
            const DeepCollectionEquality()
                .equals(other._promiseList, _promiseList) &&
            (identical(other.isFirst, isFirst) || other.isFirst == isFirst) &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

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
  _$$PromiseListImplCopyWith<_$PromiseListImpl> get copyWith =>
      __$$PromiseListImplCopyWithImpl<_$PromiseListImpl>(this, _$identity);
}

abstract class _PromiseList implements PromiseList {
  const factory _PromiseList(
      {required final List<Promise> promiseList,
      required final bool isFirst,
      required final bool isLast,
      required final bool hasNext}) = _$PromiseListImpl;

  @override
  List<Promise> get promiseList;
  @override
  bool get isFirst;
  @override
  bool get isLast;
  @override
  bool get hasNext;
  @override
  @JsonKey(ignore: true)
  _$$PromiseListImplCopyWith<_$PromiseListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
