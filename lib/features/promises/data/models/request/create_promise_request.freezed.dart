// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_promise_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreatePromiseRequest _$CreatePromiseRequestFromJson(Map<String, dynamic> json) {
  return _CreatePromiseRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePromiseRequest {
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePromiseRequestCopyWith<CreatePromiseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePromiseRequestCopyWith<$Res> {
  factory $CreatePromiseRequestCopyWith(CreatePromiseRequest value,
          $Res Function(CreatePromiseRequest) then) =
      _$CreatePromiseRequestCopyWithImpl<$Res, CreatePromiseRequest>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$CreatePromiseRequestCopyWithImpl<$Res,
        $Val extends CreatePromiseRequest>
    implements $CreatePromiseRequestCopyWith<$Res> {
  _$CreatePromiseRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$CreatePromiseRequestImplCopyWith<$Res>
    implements $CreatePromiseRequestCopyWith<$Res> {
  factory _$$CreatePromiseRequestImplCopyWith(_$CreatePromiseRequestImpl value,
          $Res Function(_$CreatePromiseRequestImpl) then) =
      __$$CreatePromiseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$CreatePromiseRequestImplCopyWithImpl<$Res>
    extends _$CreatePromiseRequestCopyWithImpl<$Res, _$CreatePromiseRequestImpl>
    implements _$$CreatePromiseRequestImplCopyWith<$Res> {
  __$$CreatePromiseRequestImplCopyWithImpl(_$CreatePromiseRequestImpl _value,
      $Res Function(_$CreatePromiseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$CreatePromiseRequestImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePromiseRequestImpl implements _CreatePromiseRequest {
  const _$CreatePromiseRequestImpl({required this.content});

  factory _$CreatePromiseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePromiseRequestImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'CreatePromiseRequest(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePromiseRequestImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePromiseRequestImplCopyWith<_$CreatePromiseRequestImpl>
      get copyWith =>
          __$$CreatePromiseRequestImplCopyWithImpl<_$CreatePromiseRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePromiseRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePromiseRequest implements CreatePromiseRequest {
  const factory _CreatePromiseRequest({required final String content}) =
      _$CreatePromiseRequestImpl;

  factory _CreatePromiseRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePromiseRequestImpl.fromJson;

  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$CreatePromiseRequestImplCopyWith<_$CreatePromiseRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
