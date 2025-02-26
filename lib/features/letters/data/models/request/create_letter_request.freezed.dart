// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_letter_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateLetterRequest _$CreateLetterRequestFromJson(Map<String, dynamic> json) {
  return _CreateLetterRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateLetterRequest {
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateLetterRequestCopyWith<CreateLetterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateLetterRequestCopyWith<$Res> {
  factory $CreateLetterRequestCopyWith(
          CreateLetterRequest value, $Res Function(CreateLetterRequest) then) =
      _$CreateLetterRequestCopyWithImpl<$Res, CreateLetterRequest>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$CreateLetterRequestCopyWithImpl<$Res, $Val extends CreateLetterRequest>
    implements $CreateLetterRequestCopyWith<$Res> {
  _$CreateLetterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateLetterRequestImplCopyWith<$Res>
    implements $CreateLetterRequestCopyWith<$Res> {
  factory _$$CreateLetterRequestImplCopyWith(_$CreateLetterRequestImpl value,
          $Res Function(_$CreateLetterRequestImpl) then) =
      __$$CreateLetterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$CreateLetterRequestImplCopyWithImpl<$Res>
    extends _$CreateLetterRequestCopyWithImpl<$Res, _$CreateLetterRequestImpl>
    implements _$$CreateLetterRequestImplCopyWith<$Res> {
  __$$CreateLetterRequestImplCopyWithImpl(_$CreateLetterRequestImpl _value,
      $Res Function(_$CreateLetterRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$CreateLetterRequestImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateLetterRequestImpl implements _CreateLetterRequest {
  const _$CreateLetterRequestImpl({required this.content});

  factory _$CreateLetterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateLetterRequestImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'CreateLetterRequest(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateLetterRequestImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateLetterRequestImplCopyWith<_$CreateLetterRequestImpl> get copyWith =>
      __$$CreateLetterRequestImplCopyWithImpl<_$CreateLetterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateLetterRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateLetterRequest implements CreateLetterRequest {
  const factory _CreateLetterRequest({required final String content}) =
      _$CreateLetterRequestImpl;

  factory _CreateLetterRequest.fromJson(Map<String, dynamic> json) =
      _$CreateLetterRequestImpl.fromJson;

  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$CreateLetterRequestImplCopyWith<_$CreateLetterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
