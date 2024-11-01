import 'package:json_annotation/json_annotation.dart';

part 'get_jwt_response.g.dart';

@JsonSerializable()
class GetJwtResponse {
  final String jwt;

  GetJwtResponse({required this.jwt});

  factory GetJwtResponse.fromJson(Map<String, dynamic> json) =>
      _$GetJwtResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetJwtResponseToJson(this);
}
