import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.register(String email, String name, String password) =
      RegisterUser;
  const factory AuthEvent.login(
      String email, String fingerprint, String password) = LoginUser;
  const factory AuthEvent.getVerificationCode(String email) =
      GetVerificationCode;
  const factory AuthEvent.verifyEmail(
      String code, String email, String fingerprint) = VerifyEmail;
  const factory AuthEvent.refreshTokens(
    String fingerprint,
    String refreshToken,
    String userId,
  ) = RefreshTokens;
  const factory AuthEvent.checkAuth(String token) = CheckAuth;
  const factory AuthEvent.logout(String refreshToken) = LogoutUser;
}
