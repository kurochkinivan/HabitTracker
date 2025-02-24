// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_habit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateHabitRequest _$CreateHabitRequestFromJson(Map<String, dynamic> json) =>
    CreateHabitRequest(
      categoryId: (json['category_id'] as num).toInt(),
      description: json['description'] as String,
      interval: json['interval'] as String,
      name: json['name'] as String,
      notificationTimes: (json['notification_times'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      scheduleDays: (json['schedule_days'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CreateHabitRequestToJson(CreateHabitRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'description': instance.description,
      'interval': instance.interval,
      'name': instance.name,
      'notification_times': instance.notificationTimes,
      'schedule_days': instance.scheduleDays,
    };
