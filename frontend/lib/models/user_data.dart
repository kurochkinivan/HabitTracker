import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  UserData({
    required this.email,
    required this.id,
    required this.name,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
