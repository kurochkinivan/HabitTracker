import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/get_categories_response.dart';
import '../../models/get_days_response.dart';
import '../../models/get_habits_response.dart';
import '../../models/habit_action_type.dart';

part 'habits_state.freezed.dart';

@freezed
class HabitsState with _$HabitsState {
  const factory HabitsState.initial() = HabitsInitial;

  const factory HabitsState.loading({
    required HabitActionType action,
  }) = HabitsLoading;

  const factory HabitsState.success({
    required HabitActionType action,
    String? message,
    List<GetDaysResponse>? days,
    List<GetCategoriesResponse>? categories,
    List<GetHabitsResponse>? habits,
  }) = HabitsSuccess;

  const factory HabitsState.failure({
    required HabitActionType action,
    required String errorMessage,
  }) = HabitsFailure;
}
