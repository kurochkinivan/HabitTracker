import 'package:json_annotation/json_annotation.dart';

part 'get_jwt_response.g.dart';

@JsonSerializable()
class GetJwtResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  GetJwtResponse({required this.accessToken, required this.refreshToken});

  factory GetJwtResponse.fromJson(Map<String, dynamic> json) =>
      _$GetJwtResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetJwtResponseToJson(this);
}
