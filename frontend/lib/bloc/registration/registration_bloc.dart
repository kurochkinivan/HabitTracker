import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/bloc/registration/registration_event.dart';
import 'package:habit_tracker/bloc/registration/registration_state.dart';
import '../../models/app_error.dart';
import '../../models/get_verification_code_request.dart';
import '../../models/register_request.dart';
import '../../models/registration_action_type.dart';
import '../../models/verify_email_request.dart';
import '../../services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  RegistrationBloc({
    required this.apiClient,
  }) : super(const RegistrationState.initial()) {
    on<RegisterUser>(_onRegisterUser);
    on<GetVerificationCode>(_onGetVerificationCode);
    on<VerifyEmail>(_onVerifyEmail);
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegistrationState> emit) async {
    emit(RegistrationState.loading(action: RegistrationActionType.register));
    try {
      final request = RegisterRequest(
        email: event.email,
        name: event.name,
        password: event.password,
      );
      await apiClient
          .registerUser(request)
          .timeout(const Duration(seconds: 15));
      emit(RegistrationState.success(
          message: 'Успешный ввод данных, выслан код на почту.',
          action: RegistrationActionType.register));
    } on TimeoutException {
      emit(RegistrationState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: RegistrationActionType.register));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(RegistrationState.failure(
            errorMessage: error.userMessage,
            action: RegistrationActionType.register));
      } else {
        emit(RegistrationState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: RegistrationActionType.register));
      }
    } catch (e) {
      emit(RegistrationState.failure(
          errorMessage: "Во время регистрации произошла непредвиденная ошибка.",
          action: RegistrationActionType.register));
    }
  }

  Future<void> _onGetVerificationCode(
      GetVerificationCode event, Emitter<RegistrationState> emit) async {
    emit(RegistrationState.loading(
        action: RegistrationActionType.getVerificationCode));
    try {
      final request = GetVerificationCodeRequest(email: event.email);
      await apiClient
          .getVerificationCode(request)
          .timeout(const Duration(seconds: 15));
      emit(RegistrationState.success(
          message: 'Код выслан повторно на почту.',
          action: RegistrationActionType.getVerificationCode));
    } on TimeoutException {
      emit(RegistrationState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: RegistrationActionType.getVerificationCode));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(RegistrationState.failure(
            errorMessage: error.userMessage,
            action: RegistrationActionType.getVerificationCode));
      } else {
        emit(RegistrationState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: RegistrationActionType.getVerificationCode));
      }
    } catch (e) {
      emit(RegistrationState.failure(
          errorMessage:
              "При отправке кода проверки произошла непредвиденная ошибка.",
          action: RegistrationActionType.getVerificationCode));
    }
  }

  Future<void> _onVerifyEmail(
      VerifyEmail event, Emitter<RegistrationState> emit) async {
    emit(RegistrationState.loading(action: RegistrationActionType.verifyEmail));
    try {
      final request = VerifyEmailRequest(
          code: event.code, email: event.email, fingerprint: event.fingerprint);

      SharedPreferences storage = await SharedPreferences.getInstance();

      final response = await apiClient
          .verifyEmail(request)
          .timeout(const Duration(seconds: 15));

      await secureStorage.write(
          key: 'access_token', value: response.accessToken);
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      await storage.setString('user_email', response.user.email);
      await storage.setString('user_name', response.user.name);
      await storage.setString('user_id', response.user.id);

      emit(RegistrationState.success(
          message: 'Email verified successfully.',
          action: RegistrationActionType.verifyEmail));
    } on TimeoutException {
      emit(RegistrationState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: RegistrationActionType.verifyEmail));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(RegistrationState.failure(
            errorMessage: error.userMessage,
            action: RegistrationActionType.verifyEmail));
      } else {
        emit(RegistrationState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: RegistrationActionType.verifyEmail));
      }
    } catch (e) {
      emit(RegistrationState.failure(
          errorMessage: "При проверке кода произошла непредвиденная ошибка.",
          action: RegistrationActionType.verifyEmail));
    }
  }
}
