import 'package:json_annotation/json_annotation.dart';

part 'create_category_request.g.dart';

@JsonSerializable()
class CreateCategoryRequest {
  final String name;

  CreateCategoryRequest({required this.name});

  factory CreateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryRequestToJson(this);
}