import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/app_error.dart';
import '../models/get_verification_code_request.dart';
import '../models/login_request.dart';
import '../models/logout_request.dart';
import '../models/refresh_tokens_request.dart';
import '../models/register_request.dart';
import '../models/verify_email_request.dart';
import '../services/api_client.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiClient apiClient;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  AuthBloc(this.apiClient) : super(const AuthState.initial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
    on<GetVerificationCode>(_onGetVerificationCode);
    on<VerifyEmail>(_onVerifyEmail);
    on<RefreshTokens>(_onRefreshTokens);
    on<CheckAuth>(_onCheckAuth);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = RegisterRequest(
        email: event.email,
        name: event.name,
        password: event.password,
      );
      await apiClient.registerUser(request).timeout(Duration(seconds: 15));
      emit(AuthState.success('Успещный ввод данных, выслан код на почту.'));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при регистрации."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "Во время регистрации произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = LoginRequest(
        email: event.email,
        fingerprint: event.fingerprint,
        password: event.password,
      );
      final response =
          await apiClient.loginUser(request).timeout(Duration(seconds: 15));
      await storage.write(key: 'access_token', value: response.accessToken);
      await storage.write(key: 'refresh_token', value: response.refreshToken);
      emit(AuthState.success('Login successful.'));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при входе в систему."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "При входе в систему произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onGetVerificationCode(
      GetVerificationCode event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = GetVerificationCodeRequest(email: event.email);
      await apiClient
          .getVerificationCode(request)
          .timeout(Duration(seconds: 15));
      emit(AuthState.success('Успещный ввод почты, выслан код на почту.'));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при отправке кода проверки."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "При отправке кода проверки произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onVerifyEmail(
      VerifyEmail event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = VerifyEmailRequest(
          code: event.code, email: event.email, fingerprint: event.fingerprint);
      final response =
          await apiClient.verifyEmail(request).timeout(Duration(seconds: 15));
      await storage.write(key: 'access_token', value: response.accessToken);
      await storage.write(key: 'refresh_token', value: response.refreshToken);
      emit(AuthState.success('Email verified successfully.'));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при проверке кода."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "При проверке кода произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onRefreshTokens(
      RefreshTokens event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = RefreshTokensRequest(
          fingerprint: event.fingerprint,
          refreshToken: event.refreshToken,
          userId: event.userId);
      final response =
          await apiClient.refreshTokens(request).timeout(Duration(seconds: 15));
      await storage.write(key: 'access_token', value: response.accessToken);
      await storage.write(key: 'refresh_token', value: response.refreshToken);
      emit(AuthState.success('New tokens get successfully.'));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при отправке токенов."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "При отправке токенов произошла непредвиденная ошибка."));
    }
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final response = await apiClient
          .checkAuth("Bearer ${event.token}")
          .timeout(const Duration(seconds: 15));
      emit(AuthState.authChecked(response.isValid));
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const AuthState.authChecked(false));
      } else if (e.error is AppError) {
        emit(AuthState.failure((e.error as AppError).userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при проверке токена."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "Произошла непредвиденная ошибка при проверке токена."));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final request = LogoutRequest(refreshToken: event.refreshToken);
      final response =
          await apiClient.logout(request).timeout(const Duration(seconds: 15));
      await storage.write(key: 'access_token', value: response.accessToken);
      await storage.write(key: 'refresh_token', value: response.refreshToken);
    } on TimeoutException {
      emit(const AuthState.failure(
          "Сервер не ответил. Пожалуйста, попробуйте еще раз."));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(AuthState.failure(error.userMessage));
      } else {
        emit(const AuthState.failure("Ошибка при выходе. Попробуйте снова."));
      }
    } catch (e) {
      emit(const AuthState.failure(
          "Произошла непредвиденная ошибка при выходе."));
    }
  }
}
