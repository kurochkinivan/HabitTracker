import 'package:freezed_annotation/freezed_annotation.dart';

part 'habits_event.freezed.dart';

@freezed
class HabitsEvent with _$HabitsEvent {
  const factory HabitsEvent.getWeekDays() = GetWeekDays;

  const factory HabitsEvent.getUserCategories({
    required String userId,
  }) = GetUserCategories;

  const factory HabitsEvent.createCategory({
    required String userId,
    required String name,
  }) = CreateCategory;

  const factory HabitsEvent.getUserHabits({
    required String userId,
  }) = GetUserHabits;

  const factory HabitsEvent.createHabit({
    required String userId,
    required int categoryId,
    required String description,
    required String interval,
    required String name,
    required List<String> notificationTimes,
    required List<int> scheduleDays,
  }) = CreateHabit;
}
