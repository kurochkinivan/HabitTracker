import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.register(String email, String name, String password) =
      RegisterUser;
  const factory AuthEvent.login(String email, String password) = LoginUser;
  const factory AuthEvent.sendVerificationCode(String email) =
      SendVerificationCode;
  const factory AuthEvent.verifyEmail(String email, String code) = VerifyEmail;
}
