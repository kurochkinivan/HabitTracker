import 'package:json_annotation/json_annotation.dart';

part 'create_habit_request.g.dart';

@JsonSerializable()
class CreateHabitRequest {
  @JsonKey(name: 'category_id')
  final int categoryId;
  final String description;
  final String interval;
  final String name;
  @JsonKey(name: 'notification_times')
  final List<String> notificationTimes;
  @JsonKey(name: 'schedule_days')
  final List<int> scheduleDays;

  CreateHabitRequest({
    required this.categoryId,
    required this.description,
    required this.interval,
    required this.name,
    required this.notificationTimes,
    required this.scheduleDays,
  });

  factory CreateHabitRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHabitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHabitRequestToJson(this);
}