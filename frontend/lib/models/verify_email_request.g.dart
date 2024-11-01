// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) =>
    VerifyEmailRequest(
      code: json['code'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$VerifyEmailRequestToJson(VerifyEmailRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'email': instance.email,
    };
