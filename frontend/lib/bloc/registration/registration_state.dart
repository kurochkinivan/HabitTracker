import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/registration_action_type.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = RegistrationInitial;

  const factory RegistrationState.loading({
    required RegistrationActionType action,
  }) = RegistrationLoading;

  const factory RegistrationState.success({
    required String message,
    required RegistrationActionType action,
  }) = RegistrationSuccess;

  const factory RegistrationState.failure({
    required String errorMessage,
    required RegistrationActionType action,
  }) = RegistrationFailure;
}
