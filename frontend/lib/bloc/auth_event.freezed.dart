// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegisterUserImplCopyWith<$Res> {
  factory _$$RegisterUserImplCopyWith(
          _$RegisterUserImpl value, $Res Function(_$RegisterUserImpl) then) =
      __$$RegisterUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String name, String password});
}

/// @nodoc
class __$$RegisterUserImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterUserImpl>
    implements _$$RegisterUserImplCopyWith<$Res> {
  __$$RegisterUserImplCopyWithImpl(
      _$RegisterUserImpl _value, $Res Function(_$RegisterUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? password = null,
  }) {
    return _then(_$RegisterUserImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterUserImpl implements RegisterUser {
  const _$RegisterUserImpl(this.email, this.name, this.password);

  @override
  final String email;
  @override
  final String name;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.register(email: $email, name: $name, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterUserImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, name, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      __$$RegisterUserImplCopyWithImpl<_$RegisterUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return register(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return register?.call(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(email, name, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class RegisterUser implements AuthEvent {
  const factory RegisterUser(
          final String email, final String name, final String password) =
      _$RegisterUserImpl;

  String get email;
  String get name;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginUserImplCopyWith<$Res> {
  factory _$$LoginUserImplCopyWith(
          _$LoginUserImpl value, $Res Function(_$LoginUserImpl) then) =
      __$$LoginUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String fingerprint, String password});
}

/// @nodoc
class __$$LoginUserImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginUserImpl>
    implements _$$LoginUserImplCopyWith<$Res> {
  __$$LoginUserImplCopyWithImpl(
      _$LoginUserImpl _value, $Res Function(_$LoginUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? fingerprint = null,
    Object? password = null,
  }) {
    return _then(_$LoginUserImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginUserImpl implements LoginUser {
  const _$LoginUserImpl(this.email, this.fingerprint, this.password);

  @override
  final String email;
  @override
  final String fingerprint;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.login(email: $email, fingerprint: $fingerprint, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, fingerprint, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      __$$LoginUserImplCopyWithImpl<_$LoginUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return login(email, fingerprint, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return login?.call(email, fingerprint, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, fingerprint, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class LoginUser implements AuthEvent {
  const factory LoginUser(
          final String email, final String fingerprint, final String password) =
      _$LoginUserImpl;

  String get email;
  String get fingerprint;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetVerificationCodeImplCopyWith<$Res> {
  factory _$$GetVerificationCodeImplCopyWith(_$GetVerificationCodeImpl value,
          $Res Function(_$GetVerificationCodeImpl) then) =
      __$$GetVerificationCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$GetVerificationCodeImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$GetVerificationCodeImpl>
    implements _$$GetVerificationCodeImplCopyWith<$Res> {
  __$$GetVerificationCodeImplCopyWithImpl(_$GetVerificationCodeImpl _value,
      $Res Function(_$GetVerificationCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$GetVerificationCodeImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetVerificationCodeImpl implements GetVerificationCode {
  const _$GetVerificationCodeImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.getVerificationCode(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetVerificationCodeImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetVerificationCodeImplCopyWith<_$GetVerificationCodeImpl> get copyWith =>
      __$$GetVerificationCodeImplCopyWithImpl<_$GetVerificationCodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return getVerificationCode(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return getVerificationCode?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (getVerificationCode != null) {
      return getVerificationCode(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return getVerificationCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return getVerificationCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (getVerificationCode != null) {
      return getVerificationCode(this);
    }
    return orElse();
  }
}

abstract class GetVerificationCode implements AuthEvent {
  const factory GetVerificationCode(final String email) =
      _$GetVerificationCodeImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetVerificationCodeImplCopyWith<_$GetVerificationCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyEmailImplCopyWith<$Res> {
  factory _$$VerifyEmailImplCopyWith(
          _$VerifyEmailImpl value, $Res Function(_$VerifyEmailImpl) then) =
      __$$VerifyEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code, String email, String fingerprint});
}

/// @nodoc
class __$$VerifyEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyEmailImpl>
    implements _$$VerifyEmailImplCopyWith<$Res> {
  __$$VerifyEmailImplCopyWithImpl(
      _$VerifyEmailImpl _value, $Res Function(_$VerifyEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? email = null,
    Object? fingerprint = null,
  }) {
    return _then(_$VerifyEmailImpl(
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyEmailImpl implements VerifyEmail {
  const _$VerifyEmailImpl(this.code, this.email, this.fingerprint);

  @override
  final String code;
  @override
  final String email;
  @override
  final String fingerprint;

  @override
  String toString() {
    return 'AuthEvent.verifyEmail(code: $code, email: $email, fingerprint: $fingerprint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, email, fingerprint);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailImplCopyWith<_$VerifyEmailImpl> get copyWith =>
      __$$VerifyEmailImplCopyWithImpl<_$VerifyEmailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return verifyEmail(code, email, fingerprint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return verifyEmail?.call(code, email, fingerprint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(code, email, fingerprint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return verifyEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return verifyEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(this);
    }
    return orElse();
  }
}

abstract class VerifyEmail implements AuthEvent {
  const factory VerifyEmail(
          final String code, final String email, final String fingerprint) =
      _$VerifyEmailImpl;

  String get code;
  String get email;
  String get fingerprint;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailImplCopyWith<_$VerifyEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTokensImplCopyWith<$Res> {
  factory _$$RefreshTokensImplCopyWith(
          _$RefreshTokensImpl value, $Res Function(_$RefreshTokensImpl) then) =
      __$$RefreshTokensImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fingerprint, String refreshToken, String userId});
}

/// @nodoc
class __$$RefreshTokensImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RefreshTokensImpl>
    implements _$$RefreshTokensImplCopyWith<$Res> {
  __$$RefreshTokensImplCopyWithImpl(
      _$RefreshTokensImpl _value, $Res Function(_$RefreshTokensImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fingerprint = null,
    Object? refreshToken = null,
    Object? userId = null,
  }) {
    return _then(_$RefreshTokensImpl(
      null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshTokensImpl implements RefreshTokens {
  const _$RefreshTokensImpl(this.fingerprint, this.refreshToken, this.userId);

  @override
  final String fingerprint;
  @override
  final String refreshToken;
  @override
  final String userId;

  @override
  String toString() {
    return 'AuthEvent.refreshTokens(fingerprint: $fingerprint, refreshToken: $refreshToken, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokensImpl &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fingerprint, refreshToken, userId);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokensImplCopyWith<_$RefreshTokensImpl> get copyWith =>
      __$$RefreshTokensImplCopyWithImpl<_$RefreshTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return refreshTokens(fingerprint, refreshToken, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return refreshTokens?.call(fingerprint, refreshToken, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (refreshTokens != null) {
      return refreshTokens(fingerprint, refreshToken, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return refreshTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return refreshTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (refreshTokens != null) {
      return refreshTokens(this);
    }
    return orElse();
  }
}

abstract class RefreshTokens implements AuthEvent {
  const factory RefreshTokens(final String fingerprint,
      final String refreshToken, final String userId) = _$RefreshTokensImpl;

  String get fingerprint;
  String get refreshToken;
  String get userId;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTokensImplCopyWith<_$RefreshTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckAuthImplCopyWith<$Res> {
  factory _$$CheckAuthImplCopyWith(
          _$CheckAuthImpl value, $Res Function(_$CheckAuthImpl) then) =
      __$$CheckAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$CheckAuthImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CheckAuthImpl>
    implements _$$CheckAuthImplCopyWith<$Res> {
  __$$CheckAuthImplCopyWithImpl(
      _$CheckAuthImpl _value, $Res Function(_$CheckAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$CheckAuthImpl(
      null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckAuthImpl implements CheckAuth {
  const _$CheckAuthImpl(this.token);

  @override
  final String token;

  @override
  String toString() {
    return 'AuthEvent.checkAuth(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckAuthImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckAuthImplCopyWith<_$CheckAuthImpl> get copyWith =>
      __$$CheckAuthImplCopyWithImpl<_$CheckAuthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return checkAuth(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return checkAuth?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (checkAuth != null) {
      return checkAuth(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return checkAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return checkAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (checkAuth != null) {
      return checkAuth(this);
    }
    return orElse();
  }
}

abstract class CheckAuth implements AuthEvent {
  const factory CheckAuth(final String token) = _$CheckAuthImpl;

  String get token;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckAuthImplCopyWith<_$CheckAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutUserImplCopyWith<$Res> {
  factory _$$LogoutUserImplCopyWith(
          _$LogoutUserImpl value, $Res Function(_$LogoutUserImpl) then) =
      __$$LogoutUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class __$$LogoutUserImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutUserImpl>
    implements _$$LogoutUserImplCopyWith<$Res> {
  __$$LogoutUserImplCopyWithImpl(
      _$LogoutUserImpl _value, $Res Function(_$LogoutUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshToken = null,
  }) {
    return _then(_$LogoutUserImpl(
      null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LogoutUserImpl implements LogoutUser {
  const _$LogoutUserImpl(this.refreshToken);

  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthEvent.logout(refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutUserImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, refreshToken);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutUserImplCopyWith<_$LogoutUserImpl> get copyWith =>
      __$$LogoutUserImplCopyWithImpl<_$LogoutUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) {
    return logout(refreshToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) {
    return logout?.call(refreshToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(refreshToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class LogoutUser implements AuthEvent {
  const factory LogoutUser(final String refreshToken) = _$LogoutUserImpl;

  String get refreshToken;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogoutUserImplCopyWith<_$LogoutUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
