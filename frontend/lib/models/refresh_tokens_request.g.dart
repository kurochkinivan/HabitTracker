// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_tokens_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokensRequest _$RefreshTokensRequestFromJson(
        Map<String, dynamic> json) =>
    RefreshTokensRequest(
      fingerprint: json['fingerprint'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$RefreshTokensRequestToJson(
        RefreshTokensRequest instance) =>
    <String, dynamic>{
      'fingerprint': instance.fingerprint,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
    };
