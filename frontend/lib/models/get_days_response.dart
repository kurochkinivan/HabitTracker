import 'package:json_annotation/json_annotation.dart';

part 'get_days_response.g.dart';

@JsonSerializable()
class GetDaysResponse {
  final int id;
  final String name;

  GetDaysResponse({required this.id, required this.name});

  factory GetDaysResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDaysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDaysResponseToJson(this);
}