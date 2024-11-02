// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_jwt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJwtResponse _$GetJwtResponseFromJson(Map<String, dynamic> json) =>
    GetJwtResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$GetJwtResponseToJson(GetJwtResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
