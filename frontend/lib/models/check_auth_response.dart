import 'package:json_annotation/json_annotation.dart';

part 'check_auth_response.g.dart';

@JsonSerializable()
class CheckAuthResponse {
  final bool isValid;

  CheckAuthResponse({required this.isValid});

  factory CheckAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAuthResponseToJson(this);
}
