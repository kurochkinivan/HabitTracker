import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthenticationInitial;
  const factory AuthenticationState.loading() = AuthenticationLoading;
  const factory AuthenticationState.authenticated(String message) =
      AuthenticationAuthenticated;
  const factory AuthenticationState.failure(String errorMessage) =
      AuthenticationFailure;
  const factory AuthenticationState.authChecked(bool isValid) =
      AuthenticationAuthChecked;
}
