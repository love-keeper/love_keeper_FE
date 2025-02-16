// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'social':
      return SocialLoginRequest.fromJson(json);
    case 'local':
      return LocalLoginRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LoginRequest',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LoginRequest {
  String get email => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String provider, String providerId)
        social,
    required TResult Function(String email, String password, String provider)
        local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String provider, String providerId)? social,
    TResult? Function(String email, String password, String provider)? local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String provider, String providerId)? social,
    TResult Function(String email, String password, String provider)? local,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialLoginRequest value) social,
    required TResult Function(LocalLoginRequest value) local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialLoginRequest value)? social,
    TResult? Function(LocalLoginRequest value)? local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialLoginRequest value)? social,
    TResult Function(LocalLoginRequest value)? local,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
          LoginRequest value, $Res Function(LoginRequest) then) =
      _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String email, String provider});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? provider = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialLoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$SocialLoginRequestImplCopyWith(_$SocialLoginRequestImpl value,
          $Res Function(_$SocialLoginRequestImpl) then) =
      __$$SocialLoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String provider, String providerId});
}

/// @nodoc
class __$$SocialLoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$SocialLoginRequestImpl>
    implements _$$SocialLoginRequestImplCopyWith<$Res> {
  __$$SocialLoginRequestImplCopyWithImpl(_$SocialLoginRequestImpl _value,
      $Res Function(_$SocialLoginRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? provider = null,
    Object? providerId = null,
  }) {
    return _then(_$SocialLoginRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialLoginRequestImpl implements SocialLoginRequest {
  const _$SocialLoginRequestImpl(
      {required this.email,
      required this.provider,
      required this.providerId,
      final String? $type})
      : $type = $type ?? 'social';

  factory _$SocialLoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialLoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String provider;
  @override
  final String providerId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginRequest.social(email: $email, provider: $provider, providerId: $providerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialLoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, provider, providerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialLoginRequestImplCopyWith<_$SocialLoginRequestImpl> get copyWith =>
      __$$SocialLoginRequestImplCopyWithImpl<_$SocialLoginRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String provider, String providerId)
        social,
    required TResult Function(String email, String password, String provider)
        local,
  }) {
    return social(email, provider, providerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String provider, String providerId)? social,
    TResult? Function(String email, String password, String provider)? local,
  }) {
    return social?.call(email, provider, providerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String provider, String providerId)? social,
    TResult Function(String email, String password, String provider)? local,
    required TResult orElse(),
  }) {
    if (social != null) {
      return social(email, provider, providerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialLoginRequest value) social,
    required TResult Function(LocalLoginRequest value) local,
  }) {
    return social(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialLoginRequest value)? social,
    TResult? Function(LocalLoginRequest value)? local,
  }) {
    return social?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialLoginRequest value)? social,
    TResult Function(LocalLoginRequest value)? local,
    required TResult orElse(),
  }) {
    if (social != null) {
      return social(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialLoginRequestImplToJson(
      this,
    );
  }
}

abstract class SocialLoginRequest implements LoginRequest {
  const factory SocialLoginRequest(
      {required final String email,
      required final String provider,
      required final String providerId}) = _$SocialLoginRequestImpl;

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =
      _$SocialLoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get provider;
  String get providerId;
  @override
  @JsonKey(ignore: true)
  _$$SocialLoginRequestImplCopyWith<_$SocialLoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocalLoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LocalLoginRequestImplCopyWith(_$LocalLoginRequestImpl value,
          $Res Function(_$LocalLoginRequestImpl) then) =
      __$$LocalLoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, String provider});
}

/// @nodoc
class __$$LocalLoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LocalLoginRequestImpl>
    implements _$$LocalLoginRequestImplCopyWith<$Res> {
  __$$LocalLoginRequestImplCopyWithImpl(_$LocalLoginRequestImpl _value,
      $Res Function(_$LocalLoginRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? provider = null,
  }) {
    return _then(_$LocalLoginRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalLoginRequestImpl implements LocalLoginRequest {
  const _$LocalLoginRequestImpl(
      {required this.email,
      required this.password,
      this.provider = "local",
      final String? $type})
      : $type = $type ?? 'local';

  factory _$LocalLoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalLoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey()
  final String provider;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginRequest.local(email: $email, password: $password, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalLoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, password, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalLoginRequestImplCopyWith<_$LocalLoginRequestImpl> get copyWith =>
      __$$LocalLoginRequestImplCopyWithImpl<_$LocalLoginRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String provider, String providerId)
        social,
    required TResult Function(String email, String password, String provider)
        local,
  }) {
    return local(email, password, provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String provider, String providerId)? social,
    TResult? Function(String email, String password, String provider)? local,
  }) {
    return local?.call(email, password, provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String provider, String providerId)? social,
    TResult Function(String email, String password, String provider)? local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(email, password, provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialLoginRequest value) social,
    required TResult Function(LocalLoginRequest value) local,
  }) {
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialLoginRequest value)? social,
    TResult? Function(LocalLoginRequest value)? local,
  }) {
    return local?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialLoginRequest value)? social,
    TResult Function(LocalLoginRequest value)? local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalLoginRequestImplToJson(
      this,
    );
  }
}

abstract class LocalLoginRequest implements LoginRequest {
  const factory LocalLoginRequest(
      {required final String email,
      required final String password,
      final String provider}) = _$LocalLoginRequestImpl;

  factory LocalLoginRequest.fromJson(Map<String, dynamic> json) =
      _$LocalLoginRequestImpl.fromJson;

  @override
  String get email;
  String get password;
  @override
  String get provider;
  @override
  @JsonKey(ignore: true)
  _$$LocalLoginRequestImplCopyWith<_$LocalLoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
