// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String fingerprint, String password)
        login,
    required TResult Function(
            String fingerprint, String refreshToken, String userId)
        refreshTokens,
    required TResult Function(String token) checkAuth,
    required TResult Function(String refreshToken) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String fingerprint, String password)? login,
    TResult? Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult? Function(String token)? checkAuth,
    TResult? Function(String refreshToken)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String fingerprint, String password)? login,
    TResult Function(String fingerprint, String refreshToken, String userId)?
        refreshTokens,
    TResult Function(String token)? checkAuth,
    TResult Function(String refreshToken)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUser value) login,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUser value)? login,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUser value)? login,
    TResult Function(RefreshTokens value)? refreshTokens,
    TResult Function(CheckAuth value)? checkAuth,
    TResult Function(LogoutUser value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationEventCopyWith<$Res> {
  factory $AuthenticationEventCopyWith(
          AuthenticationEvent value, $Res Function(AuthenticationEvent) then) =
      _$AuthenticationEventCopyWithImpl<$Res, AuthenticationEvent>;
}

/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res, $Val extends AuthenticationEvent>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
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
    extends _$AuthenticationEventCopyWithImpl<$Res, _$LoginUserImpl>
    implements _$$LoginUserImplCopyWith<$Res> {
  __$$LoginUserImplCopyWithImpl(
      _$LoginUserImpl _value, $Res Function(_$LoginUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? fingerprint = null,
    Object? password = null,
  }) {
    return _then(_$LoginUserImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fingerprint: null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginUserImpl implements LoginUser {
  const _$LoginUserImpl(
      {required this.email, required this.fingerprint, required this.password});

  @override
  final String email;
  @override
  final String fingerprint;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthenticationEvent.login(email: $email, fingerprint: $fingerprint, password: $password)';
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

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      __$$LoginUserImplCopyWithImpl<_$LoginUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String fingerprint, String password)
        login,
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
    TResult? Function(String email, String fingerprint, String password)? login,
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
    TResult Function(String email, String fingerprint, String password)? login,
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
    required TResult Function(LoginUser value) login,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUser value)? login,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUser value)? login,
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

abstract class LoginUser implements AuthenticationEvent {
  const factory LoginUser(
      {required final String email,
      required final String fingerprint,
      required final String password}) = _$LoginUserImpl;

  String get email;
  String get fingerprint;
  String get password;

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
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
    extends _$AuthenticationEventCopyWithImpl<$Res, _$RefreshTokensImpl>
    implements _$$RefreshTokensImplCopyWith<$Res> {
  __$$RefreshTokensImplCopyWithImpl(
      _$RefreshTokensImpl _value, $Res Function(_$RefreshTokensImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fingerprint = null,
    Object? refreshToken = null,
    Object? userId = null,
  }) {
    return _then(_$RefreshTokensImpl(
      fingerprint: null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshTokensImpl implements RefreshTokens {
  const _$RefreshTokensImpl(
      {required this.fingerprint,
      required this.refreshToken,
      required this.userId});

  @override
  final String fingerprint;
  @override
  final String refreshToken;
  @override
  final String userId;

  @override
  String toString() {
    return 'AuthenticationEvent.refreshTokens(fingerprint: $fingerprint, refreshToken: $refreshToken, userId: $userId)';
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

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokensImplCopyWith<_$RefreshTokensImpl> get copyWith =>
      __$$RefreshTokensImplCopyWithImpl<_$RefreshTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String fingerprint, String password)
        login,
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
    TResult? Function(String email, String fingerprint, String password)? login,
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
    TResult Function(String email, String fingerprint, String password)? login,
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
    required TResult Function(LoginUser value) login,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return refreshTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUser value)? login,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return refreshTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUser value)? login,
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

abstract class RefreshTokens implements AuthenticationEvent {
  const factory RefreshTokens(
      {required final String fingerprint,
      required final String refreshToken,
      required final String userId}) = _$RefreshTokensImpl;

  String get fingerprint;
  String get refreshToken;
  String get userId;

  /// Create a copy of AuthenticationEvent
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
    extends _$AuthenticationEventCopyWithImpl<$Res, _$CheckAuthImpl>
    implements _$$CheckAuthImplCopyWith<$Res> {
  __$$CheckAuthImplCopyWithImpl(
      _$CheckAuthImpl _value, $Res Function(_$CheckAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$CheckAuthImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckAuthImpl implements CheckAuth {
  const _$CheckAuthImpl({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'AuthenticationEvent.checkAuth(token: $token)';
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

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckAuthImplCopyWith<_$CheckAuthImpl> get copyWith =>
      __$$CheckAuthImplCopyWithImpl<_$CheckAuthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String fingerprint, String password)
        login,
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
    TResult? Function(String email, String fingerprint, String password)? login,
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
    TResult Function(String email, String fingerprint, String password)? login,
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
    required TResult Function(LoginUser value) login,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return checkAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUser value)? login,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return checkAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUser value)? login,
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

abstract class CheckAuth implements AuthenticationEvent {
  const factory CheckAuth({required final String token}) = _$CheckAuthImpl;

  String get token;

  /// Create a copy of AuthenticationEvent
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
    extends _$AuthenticationEventCopyWithImpl<$Res, _$LogoutUserImpl>
    implements _$$LogoutUserImplCopyWith<$Res> {
  __$$LogoutUserImplCopyWithImpl(
      _$LogoutUserImpl _value, $Res Function(_$LogoutUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshToken = null,
  }) {
    return _then(_$LogoutUserImpl(
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LogoutUserImpl implements LogoutUser {
  const _$LogoutUserImpl({required this.refreshToken});

  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthenticationEvent.logout(refreshToken: $refreshToken)';
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

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutUserImplCopyWith<_$LogoutUserImpl> get copyWith =>
      __$$LogoutUserImplCopyWithImpl<_$LogoutUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String fingerprint, String password)
        login,
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
    TResult? Function(String email, String fingerprint, String password)? login,
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
    TResult Function(String email, String fingerprint, String password)? login,
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
    required TResult Function(LoginUser value) login,
    required TResult Function(RefreshTokens value) refreshTokens,
    required TResult Function(CheckAuth value) checkAuth,
    required TResult Function(LogoutUser value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUser value)? login,
    TResult? Function(RefreshTokens value)? refreshTokens,
    TResult? Function(CheckAuth value)? checkAuth,
    TResult? Function(LogoutUser value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUser value)? login,
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

abstract class LogoutUser implements AuthenticationEvent {
  const factory LogoutUser({required final String refreshToken}) =
      _$LogoutUserImpl;

  String get refreshToken;

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogoutUserImplCopyWith<_$LogoutUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
