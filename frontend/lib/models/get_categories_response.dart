import 'package:json_annotation/json_annotation.dart';

part 'get_categories_response.g.dart';

@JsonSerializable()
class GetCategoriesResponse {
  final int id;
  final String name;

  GetCategoriesResponse({required this.id, required this.name});

  factory GetCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoriesResponseToJson(this);
}