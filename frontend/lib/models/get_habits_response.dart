import 'package:json_annotation/json_annotation.dart';

part 'get_habits_response.g.dart';

@JsonSerializable()
class GetHabitsResponse {
  @JsonKey(name: 'category_name')
  final String categoryName;
  final String description;
  final int id;
  final String interval;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final String name;
  @JsonKey(name: 'notification_times')
  final List<String> notificationTimes;
  @JsonKey(name: 'popularity_index')
  final double popularityIndex;
  @JsonKey(name: 'schedule_days')
  final List<String> scheduleDays;

  GetHabitsResponse({
    required this.categoryName,
    required this.description,
    required this.id,
    required this.interval,
    required this.isActive,
    required this.name,
    required this.notificationTimes,
    required this.popularityIndex,
    required this.scheduleDays,
  });

  factory GetHabitsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHabitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHabitsResponseToJson(this);
}
