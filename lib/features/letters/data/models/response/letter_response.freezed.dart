// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LetterResponse _$LetterResponseFromJson(Map<String, dynamic> json) {
  return _LetterResponse.fromJson(json);
}

/// @nodoc
mixin _$LetterResponse {
  String get senderNickname => throw _privateConstructorUsedError;
  String get receiverNickname => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get sentDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LetterResponseCopyWith<LetterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterResponseCopyWith<$Res> {
  factory $LetterResponseCopyWith(
          LetterResponse value, $Res Function(LetterResponse) then) =
      _$LetterResponseCopyWithImpl<$Res, LetterResponse>;
  @useResult
  $Res call(
      {String senderNickname,
      String receiverNickname,
      String content,
      String sentDate});
}

/// @nodoc
class _$LetterResponseCopyWithImpl<$Res, $Val extends LetterResponse>
    implements $LetterResponseCopyWith<$Res> {
  _$LetterResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$LetterResponseImplCopyWith<$Res>
    implements $LetterResponseCopyWith<$Res> {
  factory _$$LetterResponseImplCopyWith(_$LetterResponseImpl value,
          $Res Function(_$LetterResponseImpl) then) =
      __$$LetterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderNickname,
      String receiverNickname,
      String content,
      String sentDate});
}

/// @nodoc
class __$$LetterResponseImplCopyWithImpl<$Res>
    extends _$LetterResponseCopyWithImpl<$Res, _$LetterResponseImpl>
    implements _$$LetterResponseImplCopyWith<$Res> {
  __$$LetterResponseImplCopyWithImpl(
      _$LetterResponseImpl _value, $Res Function(_$LetterResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderNickname = null,
    Object? receiverNickname = null,
    Object? content = null,
    Object? sentDate = null,
  }) {
    return _then(_$LetterResponseImpl(
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
@JsonSerializable()
class _$LetterResponseImpl implements _LetterResponse {
  const _$LetterResponseImpl(
      {required this.senderNickname,
      required this.receiverNickname,
      required this.content,
      required this.sentDate});

  factory _$LetterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LetterResponseImplFromJson(json);

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
    return 'LetterResponse(senderNickname: $senderNickname, receiverNickname: $receiverNickname, content: $content, sentDate: $sentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterResponseImpl &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.receiverNickname, receiverNickname) ||
                other.receiverNickname == receiverNickname) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, senderNickname, receiverNickname, content, sentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterResponseImplCopyWith<_$LetterResponseImpl> get copyWith =>
      __$$LetterResponseImplCopyWithImpl<_$LetterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LetterResponseImplToJson(
      this,
    );
  }
}

abstract class _LetterResponse implements LetterResponse {
  const factory _LetterResponse(
      {required final String senderNickname,
      required final String receiverNickname,
      required final String content,
      required final String sentDate}) = _$LetterResponseImpl;

  factory _LetterResponse.fromJson(Map<String, dynamic> json) =
      _$LetterResponseImpl.fromJson;

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
  _$$LetterResponseImplCopyWith<_$LetterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
