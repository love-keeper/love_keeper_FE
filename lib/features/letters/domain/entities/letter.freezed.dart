// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Letter {
  String get senderNickname => throw _privateConstructorUsedError;
  String get receiverNickname => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get sentDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LetterCopyWith<Letter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterCopyWith<$Res> {
  factory $LetterCopyWith(Letter value, $Res Function(Letter) then) =
      _$LetterCopyWithImpl<$Res, Letter>;
  @useResult
  $Res call(
      {String senderNickname,
      String receiverNickname,
      String content,
      String sentDate});
}

/// @nodoc
class _$LetterCopyWithImpl<$Res, $Val extends Letter>
    implements $LetterCopyWith<$Res> {
  _$LetterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderNickname = null,
    Object? receiverNickname = null,
    Object? content = null,
    Object? sentDate = null,
  }) {
    return _then(_value.copyWith(
      senderNickname: null == senderNickname
          ? _value.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      receiverNickname: null == receiverNickname
          ? _value.receiverNickname
          : receiverNickname // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: null == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LetterImplCopyWith<$Res> implements $LetterCopyWith<$Res> {
  factory _$$LetterImplCopyWith(
          _$LetterImpl value, $Res Function(_$LetterImpl) then) =
      __$$LetterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderNickname,
      String receiverNickname,
      String content,
      String sentDate});
}

/// @nodoc
class __$$LetterImplCopyWithImpl<$Res>
    extends _$LetterCopyWithImpl<$Res, _$LetterImpl>
    implements _$$LetterImplCopyWith<$Res> {
  __$$LetterImplCopyWithImpl(
      _$LetterImpl _value, $Res Function(_$LetterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderNickname = null,
    Object? receiverNickname = null,
    Object? content = null,
    Object? sentDate = null,
  }) {
    return _then(_$LetterImpl(
      senderNickname: null == senderNickname
          ? _value.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      receiverNickname: null == receiverNickname
          ? _value.receiverNickname
          : receiverNickname // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: null == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LetterImpl implements _Letter {
  const _$LetterImpl(
      {required this.senderNickname,
      required this.receiverNickname,
      required this.content,
      required this.sentDate});

  @override
  final String senderNickname;
  @override
  final String receiverNickname;
  @override
  final String content;
  @override
  final String sentDate;

  @override
  String toString() {
    return 'Letter(senderNickname: $senderNickname, receiverNickname: $receiverNickname, content: $content, sentDate: $sentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterImpl &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.receiverNickname, receiverNickname) ||
                other.receiverNickname == receiverNickname) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, senderNickname, receiverNickname, content, sentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      __$$LetterImplCopyWithImpl<_$LetterImpl>(this, _$identity);
}

abstract class _Letter implements Letter {
  const factory _Letter(
      {required final String senderNickname,
      required final String receiverNickname,
      required final String content,
      required final String sentDate}) = _$LetterImpl;

  @override
  String get senderNickname;
  @override
  String get receiverNickname;
  @override
  String get content;
  @override
  String get sentDate;
  @override
  @JsonKey(ignore: true)
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
