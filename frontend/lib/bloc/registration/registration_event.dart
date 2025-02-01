import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_event.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.register({
    required String email,
    required String name,
    required String password,
  }) = RegisterUser;

  const factory RegistrationEvent.getVerificationCode({
    required String email,
  }) = GetVerificationCode;

  const factory RegistrationEvent.verifyEmail({
    required String code,
    required String email,
    required String fingerprint,
  }) = VerifyEmail;
}
