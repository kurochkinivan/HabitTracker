// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppError _$AppErrorFromJson(Map<String, dynamic> json) => AppError(
      code: json['code'] as String,
      devMessage: json['dev_message'] as String,
      userMessage: json['user_message'] as String,
      errMessage: json['err_message'] as String?,
    );

Map<String, dynamic> _$AppErrorToJson(AppError instance) => <String, dynamic>{
      'code': instance.code,
      'dev_message': instance.devMessage,
      'user_message': instance.userMessage,
      'err_message': instance.errMessage,
    };
