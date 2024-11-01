import 'package:json_annotation/json_annotation.dart';

part 'get_verification_code_request.g.dart';

@JsonSerializable()
class GetVerificationCodeRequest {
  final String email;

  GetVerificationCodeRequest({required this.email});

  factory GetVerificationCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetVerificationCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetVerificationCodeRequestToJson(this);
}
