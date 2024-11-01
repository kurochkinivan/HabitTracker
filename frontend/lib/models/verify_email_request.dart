import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request.g.dart';

@JsonSerializable()
class VerifyEmailRequest {
  final String code;
  final String email;

  VerifyEmailRequest({
    required this.code,
    required this.email,
  });

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);
}
