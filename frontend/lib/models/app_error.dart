import 'package:json_annotation/json_annotation.dart';

part 'app_error.g.dart';

@JsonSerializable()
class AppError {
  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'dev_message')
  final String devMessage;

  @JsonKey(name: 'user_message')
  final String userMessage;

  @JsonKey(name: 'err_message')
  final String? errMessage;

  AppError({
    required this.code,
    required this.devMessage,
    required this.userMessage,
    this.errMessage,
  });

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);

  Map<String, dynamic> toJson() => _$AppErrorToJson(this);
}
