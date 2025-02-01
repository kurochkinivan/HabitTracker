import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.freezed.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.login({
    required String email,
    required String fingerprint,
    required String password,
  }) = LoginUser;

  const factory AuthenticationEvent.refreshTokens({
    required String fingerprint,
    required String refreshToken,
    required String userId,
  }) = RefreshTokens;

  const factory AuthenticationEvent.checkAuth({
    required String token,
  }) = CheckAuth;

  const factory AuthenticationEvent.logout({
    required String refreshToken,
  }) = LogoutUser;
}
