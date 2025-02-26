// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LetterList {
  List<Letter> get letterList => throw _privateConstructorUsedError;
  bool get isFirst => throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LetterListCopyWith<LetterList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterListCopyWith<$Res> {
  factory $LetterListCopyWith(
          LetterList value, $Res Function(LetterList) then) =
      _$LetterListCopyWithImpl<$Res, LetterList>;
  @useResult
  $Res call({List<Letter> letterList, bool isFirst, bool isLast, bool hasNext});
}

/// @nodoc
class _$LetterListCopyWithImpl<$Res, $Val extends LetterList>
    implements $LetterListCopyWith<$Res> {
  _$LetterListCopyWithImpl(this._value, this._then);

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
              as List<Letter>,
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
abstract class _$$LetterListImplCopyWith<$Res>
    implements $LetterListCopyWith<$Res> {
  factory _$$LetterListImplCopyWith(
          _$LetterListImpl value, $Res Function(_$LetterListImpl) then) =
      __$$LetterListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Letter> letterList, bool isFirst, bool isLast, bool hasNext});
}

/// @nodoc
class __$$LetterListImplCopyWithImpl<$Res>
    extends _$LetterListCopyWithImpl<$Res, _$LetterListImpl>
    implements _$$LetterListImplCopyWith<$Res> {
  __$$LetterListImplCopyWithImpl(
      _$LetterListImpl _value, $Res Function(_$LetterListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letterList = null,
    Object? isFirst = null,
    Object? isLast = null,
    Object? hasNext = null,
  }) {
    return _then(_$LetterListImpl(
      letterList: null == letterList
          ? _value._letterList
          : letterList // ignore: cast_nullable_to_non_nullable
              as List<Letter>,
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

class _$LetterListImpl implements _LetterList {
  const _$LetterListImpl(
      {required final List<Letter> letterList,
      required this.isFirst,
      required this.isLast,
      required this.hasNext})
      : _letterList = letterList;

  final List<Letter> _letterList;
  @override
  List<Letter> get letterList {
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
    return 'LetterList(letterList: $letterList, isFirst: $isFirst, isLast: $isLast, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterListImpl &&
            const DeepCollectionEquality()
                .equals(other._letterList, _letterList) &&
            (identical(other.isFirst, isFirst) || other.isFirst == isFirst) &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

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
  _$$LetterListImplCopyWith<_$LetterListImpl> get copyWith =>
      __$$LetterListImplCopyWithImpl<_$LetterListImpl>(this, _$identity);
}

abstract class _LetterList implements LetterList {
  const factory _LetterList(
      {required final List<Letter> letterList,
      required final bool isFirst,
      required final bool isLast,
      required final bool hasNext}) = _$LetterListImpl;

  @override
  List<Letter> get letterList;
  @override
  bool get isFirst;
  @override
  bool get isLast;
  @override
  bool get hasNext;
  @override
  @JsonKey(ignore: true)
  _$$LetterListImplCopyWith<_$LetterListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
