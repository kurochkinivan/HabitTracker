import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../models/app_error.dart';
import '../../models/create_category_request.dart';
import '../../models/create_habit_request.dart';
import '../../models/habit_action_type.dart';
import '../../services/api_client.dart';
import 'habits_event.dart';
import 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final ApiClient apiClient;

  HabitsBloc({required this.apiClient}) : super(const HabitsState.initial()) {
    on<GetWeekDays>(_onGetWeekDays);
    on<GetUserCategories>(_onGetUserCategories);
    on<CreateCategory>(_onCreateCategory);
    on<GetUserHabits>(_onGetUserHabits);
    on<CreateHabit>(_onCreateHabit);
  }

  Future<void> _onGetWeekDays(
      GetWeekDays event, Emitter<HabitsState> emit) async {
    emit(HabitsState.loading(action: HabitActionType.getWeekDays));
    try {
      final days =
          await apiClient.getWeekDays().timeout(const Duration(seconds: 15));
      emit(
          HabitsState.success(action: HabitActionType.getWeekDays, days: days));
    } on TimeoutException {
      emit(HabitsState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: HabitActionType.getWeekDays));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(HabitsState.failure(
            errorMessage: error.userMessage,
            action: HabitActionType.getWeekDays));
      } else {
        emit(HabitsState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: HabitActionType.getWeekDays));
      }
    } catch (_) {
      emit(HabitsState.failure(
          errorMessage: "Произошла непредвиденная ошибка.",
          action: HabitActionType.getWeekDays));
    }
  }

  Future<void> _onGetUserCategories(
      GetUserCategories event, Emitter<HabitsState> emit) async {
    emit(HabitsState.loading(action: HabitActionType.getUserCategories));
    try {
      final categories = await apiClient
          .getUserCategories(event.userId)
          .timeout(const Duration(seconds: 15));
      emit(HabitsState.success(
          action: HabitActionType.getUserCategories, categories: categories));
    } on TimeoutException {
      emit(HabitsState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: HabitActionType.getUserCategories));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(HabitsState.failure(
            errorMessage: error.userMessage,
            action: HabitActionType.getUserCategories));
      } else {
        emit(HabitsState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: HabitActionType.getUserCategories));
      }
    } catch (_) {
      emit(HabitsState.failure(
          errorMessage: "Произошла непредвиденная ошибка.",
          action: HabitActionType.getUserCategories));
    }
  }

  Future<void> _onCreateCategory(
      CreateCategory event, Emitter<HabitsState> emit) async {
    emit(HabitsState.loading(action: HabitActionType.createCategory));
    try {
      final request = CreateCategoryRequest(name: event.name);
      await apiClient
          .createCategory(event.userId, request)
          .timeout(const Duration(seconds: 15));
      emit(HabitsState.success(
          action: HabitActionType.createCategory,
          message: "Категория успешно создана."));
    } on TimeoutException {
      emit(HabitsState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: HabitActionType.createCategory));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(HabitsState.failure(
            errorMessage: error.userMessage,
            action: HabitActionType.createCategory));
      } else {
        emit(HabitsState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: HabitActionType.createCategory));
      }
    } catch (_) {
      emit(HabitsState.failure(
          errorMessage: "Произошла непредвиденная ошибка.",
          action: HabitActionType.createCategory));
    }
  }

  Future<void> _onGetUserHabits(
      GetUserHabits event, Emitter<HabitsState> emit) async {
    emit(HabitsState.loading(action: HabitActionType.getUserHabits));
    try {
      final habits = await apiClient
          .getUserHabits(event.userId)
          .timeout(const Duration(seconds: 15));
      emit(HabitsState.success(
          action: HabitActionType.getUserHabits, habits: habits));
    } on TimeoutException {
      emit(HabitsState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: HabitActionType.getUserHabits));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(HabitsState.failure(
            errorMessage: error.userMessage,
            action: HabitActionType.getUserHabits));
      } else {
        emit(HabitsState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: HabitActionType.getUserHabits));
      }
    } catch (_) {
      emit(HabitsState.failure(
          errorMessage: "Произошла непредвиденная ошибка.",
          action: HabitActionType.getUserHabits));
    }
  }

  Future<void> _onCreateHabit(
      CreateHabit event, Emitter<HabitsState> emit) async {
    emit(HabitsState.loading(action: HabitActionType.createHabit));
    try {
      final request = CreateHabitRequest(
        categoryId: event.categoryId,
        description: event.description,
        interval: event.interval,
        name: event.name,
        notificationTimes: event.notificationTimes,
        scheduleDays: event.scheduleDays,
      );
      await apiClient
          .createHabit(event.userId, request)
          .timeout(const Duration(seconds: 15));
      emit(HabitsState.success(
          action: HabitActionType.createHabit,
          message: "Привычка успешно создана."));
    } on TimeoutException {
      emit(HabitsState.failure(
          errorMessage: "Сервер не ответил. Пожалуйста, попробуйте еще раз.",
          action: HabitActionType.createHabit));
    } on DioException catch (e) {
      final error = e.error;
      if (error is AppError) {
        emit(HabitsState.failure(
            errorMessage: error.userMessage,
            action: HabitActionType.createHabit));
      } else {
        emit(HabitsState.failure(
            errorMessage: "Ошибка доступа к серверу.",
            action: HabitActionType.createHabit));
      }
    } catch (_) {
      emit(HabitsState.failure(
          errorMessage: "Произошла непредвиденная ошибка.",
          action: HabitActionType.createHabit));
    }
  }
}
