// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoriesResponse _$GetCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GetCategoriesResponseToJson(
        GetCategoriesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
