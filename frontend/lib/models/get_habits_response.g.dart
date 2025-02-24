// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_habits_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHabitsResponse _$GetHabitsResponseFromJson(Map<String, dynamic> json) =>
    GetHabitsResponse(
      categoryName: json['category_name'] as String,
      description: json['description'] as String,
      id: (json['id'] as num).toInt(),
      interval: json['interval'] as String,
      isActive: json['is_active'] as bool,
      name: json['name'] as String,
      notificationTimes: (json['notification_times'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      popularityIndex: (json['popularity_index'] as num).toDouble(),
      scheduleDays: (json['schedule_days'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetHabitsResponseToJson(GetHabitsResponse instance) =>
    <String, dynamic>{
      'category_name': instance.categoryName,
      'description': instance.description,
      'id': instance.id,
      'interval': instance.interval,
      'is_active': instance.isActive,
      'name': instance.name,
      'notification_times': instance.notificationTimes,
      'popularity_index': instance.popularityIndex,
      'schedule_days': instance.scheduleDays,
    };
