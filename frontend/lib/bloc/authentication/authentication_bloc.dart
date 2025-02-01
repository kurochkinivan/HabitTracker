import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/app_error.dart';
import '../../models/login_request.dart';
import '../../models/logout_request.dart';
import '../../models/refresh_tokens_request.dart';
import '../../services/api_client.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthenticationBloc({
    required this.apiClient,
  }) : super(const AuthenticationState.initial()) {
    on<LoginUser>(_onLoginUser);
    on<RefreshTokens>(_onRefreshTokens);
    on<CheckAuth>(_onCheckAuth);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onLoginUser(
      LoginUser event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());
    try {
      final request = LoginRequest(
        email: event.email,
        fingerprint: event.fingerprint,
        password: event.password,
      );
      final response = await apiClient
          .loginUser(request)
          .timeout(const Duration(seconds: 15));
      await secureStorage.write(
          key: 'access_token', value: response.accessToken);
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      emit(AuthenticationState.authenticated('Login successful.'));
    } on TimeoutException {
      emit(const AuthenticationState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthenticationState.failure(error.userMessage));
      } else {
        emit(const AuthenticationState.failure("Ошибка доступа к серверу."));
      }
    } catch (e) {
      emit(const AuthenticationState.failure(
          "При входе в систему произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onRefreshTokens(
      RefreshTokens event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());
    try {
      final request = RefreshTokensRequest(
          fingerprint: event.fingerprint,
          refreshToken: event.refreshToken,
          userId: event.userId);
      final response = await apiClient
          .refreshTokens(request)
          .timeout(const Duration(seconds: 15));
      await secureStorage.write(
          key: 'access_token', value: response.accessToken);
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      emit(AuthenticationState.authenticated('New tokens get successfully.'));
    } on TimeoutException {
      emit(const AuthenticationState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthenticationState.failure(error.userMessage));
      } else {
        emit(const AuthenticationState.failure("Ошибка доступа к серверу."));
      }
    } catch (e) {
      emit(const AuthenticationState.failure(
          "При отправке токенов произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onCheckAuth(
      CheckAuth event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());
    try {
      final response = await apiClient
          .checkAuth("Bearer ${event.token}")
          .timeout(const Duration(seconds: 15));
      emit(AuthenticationState.authChecked(response.isValid));
    } on TimeoutException {
      emit(const AuthenticationState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationState.authChecked(false));
      } else if (e.error is AppError) {
        emit(AuthenticationState.failure((e.error as AppError).userMessage));
      } else {
        emit(const AuthenticationState.failure("Ошибка доступа к серверу."));
      }
    } catch (e) {
      emit(const AuthenticationState.failure(
          "Произошла непредвиденная ошибка при проверке токена."));
    }
  }

  Future<void> _onLogoutUser(
      LogoutUser event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());
    try {
      final request = LogoutRequest(refreshToken: event.refreshToken);
      final response =
          await apiClient.logout(request).timeout(const Duration(seconds: 15));
      await secureStorage.write(
          key: 'access_token', value: response.accessToken);
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      emit(AuthenticationState.authenticated('Logout successful.'));
    } on TimeoutException {
      emit(const AuthenticationState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthenticationState.failure(error.userMessage));
      } else {
        emit(const AuthenticationState.failure("Ошибка доступа к серверу."));
      }
    } catch (e) {
      emit(const AuthenticationState.failure(
          "Произошла непредвиденная ошибка при выходе."));
    }
  }
}
