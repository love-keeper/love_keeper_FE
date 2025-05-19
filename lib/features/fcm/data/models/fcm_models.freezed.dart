// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FCMTokenRequest _$FCMTokenRequestFromJson(Map<String, dynamic> json) {
  return _$FCMTokenRequestImpl.fromJson(json);
}

/// @nodoc
mixin _$FCMTokenRequest {
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FCMTokenRequestCopyWith<FCMTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FCMTokenRequestCopyWith<$Res> {
  factory $FCMTokenRequestCopyWith(
          FCMTokenRequest value, $Res Function(FCMTokenRequest) then) =
      _$FCMTokenRequestCopyWithImpl<$Res, FCMTokenRequest>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$FCMTokenRequestCopyWithImpl<$Res, $Val extends FCMTokenRequest>
    implements $FCMTokenRequestCopyWith<$Res> {
  _$FCMTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$FCMTokenRequestImplImplCopyWith<$Res>
    implements $FCMTokenRequestCopyWith<$Res> {
  factory _$$$FCMTokenRequestImplImplCopyWith(_$$FCMTokenRequestImplImpl value,
          $Res Function(_$$FCMTokenRequestImplImpl) then) =
      __$$$FCMTokenRequestImplImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$$FCMTokenRequestImplImplCopyWithImpl<$Res>
    extends _$FCMTokenRequestCopyWithImpl<$Res, _$$FCMTokenRequestImplImpl>
    implements _$$$FCMTokenRequestImplImplCopyWith<$Res> {
  __$$$FCMTokenRequestImplImplCopyWithImpl(_$$FCMTokenRequestImplImpl _value,
      $Res Function(_$$FCMTokenRequestImplImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$$FCMTokenRequestImplImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$$FCMTokenRequestImplImpl implements _$FCMTokenRequestImpl {
  const _$$FCMTokenRequestImplImpl({required this.token});

  factory _$$FCMTokenRequestImplImpl.fromJson(Map<String, dynamic> json) =>
      _$$$FCMTokenRequestImplImplFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'FCMTokenRequest(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$FCMTokenRequestImplImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$FCMTokenRequestImplImplCopyWith<_$$FCMTokenRequestImplImpl>
      get copyWith =>
          __$$$FCMTokenRequestImplImplCopyWithImpl<_$$FCMTokenRequestImplImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$$FCMTokenRequestImplImplToJson(
      this,
    );
  }
}

abstract class _$FCMTokenRequestImpl implements FCMTokenRequest {
  const factory _$FCMTokenRequestImpl({required final String token}) =
      _$$FCMTokenRequestImplImpl;

  factory _$FCMTokenRequestImpl.fromJson(Map<String, dynamic> json) =
      _$$FCMTokenRequestImplImpl.fromJson;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$$FCMTokenRequestImplImplCopyWith<_$$FCMTokenRequestImplImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PushNotificationResponse _$PushNotificationResponseFromJson(
    Map<String, dynamic> json) {
  return _PushNotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationResponse {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get relativeTime => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PushNotificationResponseCopyWith<PushNotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationResponseCopyWith<$Res> {
  factory $PushNotificationResponseCopyWith(PushNotificationResponse value,
          $Res Function(PushNotificationResponse) then) =
      _$PushNotificationResponseCopyWithImpl<$Res, PushNotificationResponse>;
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String relativeTime,
      bool read,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$PushNotificationResponseCopyWithImpl<$Res,
        $Val extends PushNotificationResponse>
    implements $PushNotificationResponseCopyWith<$Res> {
  _$PushNotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? relativeTime = null,
    Object? read = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      relativeTime: null == relativeTime
          ? _value.relativeTime
          : relativeTime // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationResponseImplCopyWith<$Res>
    implements $PushNotificationResponseCopyWith<$Res> {
  factory _$$PushNotificationResponseImplCopyWith(
          _$PushNotificationResponseImpl value,
          $Res Function(_$PushNotificationResponseImpl) then) =
      __$$PushNotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String relativeTime,
      bool read,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$PushNotificationResponseImplCopyWithImpl<$Res>
    extends _$PushNotificationResponseCopyWithImpl<$Res,
        _$PushNotificationResponseImpl>
    implements _$$PushNotificationResponseImplCopyWith<$Res> {
  __$$PushNotificationResponseImplCopyWithImpl(
      _$PushNotificationResponseImpl _value,
      $Res Function(_$PushNotificationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? relativeTime = null,
    Object? read = null,
    Object? data = freezed,
  }) {
    return _then(_$PushNotificationResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      relativeTime: null == relativeTime
          ? _value.relativeTime
          : relativeTime // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationResponseImpl implements _PushNotificationResponse {
  const _$PushNotificationResponseImpl(
      {required this.id,
      required this.title,
      required this.body,
      required this.relativeTime,
      required this.read,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$PushNotificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String relativeTime;
  @override
  final bool read;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PushNotificationResponse(id: $id, title: $title, body: $body, relativeTime: $relativeTime, read: $read, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.relativeTime, relativeTime) ||
                other.relativeTime == relativeTime) &&
            (identical(other.read, read) || other.read == read) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, relativeTime,
      read, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationResponseImplCopyWith<_$PushNotificationResponseImpl>
      get copyWith => __$$PushNotificationResponseImplCopyWithImpl<
          _$PushNotificationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationResponseImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationResponse implements PushNotificationResponse {
  const factory _PushNotificationResponse(
      {required final int id,
      required final String title,
      required final String body,
      required final String relativeTime,
      required final bool read,
      final Map<String, dynamic>? data}) = _$PushNotificationResponseImpl;

  factory _PushNotificationResponse.fromJson(Map<String, dynamic> json) =
      _$PushNotificationResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get relativeTime;
  @override
  bool get read;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$PushNotificationResponseImplCopyWith<_$PushNotificationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
