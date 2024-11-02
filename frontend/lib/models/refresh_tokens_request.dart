import 'package:json_annotation/json_annotation.dart';

part 'refresh_tokens_request.g.dart';

@JsonSerializable()
class RefreshTokensRequest {
  final String fingerprint;
  final String refreshToken;
  final String userId;

  RefreshTokensRequest({
    required this.fingerprint,
    required this.refreshToken,
    required this.userId,
  });

  factory RefreshTokensRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokensRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokensRequestToJson(this);
}
