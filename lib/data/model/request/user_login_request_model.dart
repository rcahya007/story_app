import 'package:json_annotation/json_annotation.dart';

part 'user_login_request_model.g.dart';

@JsonSerializable()
class UserLoginRequestModel {
  final String? email;
  final String? password;

  UserLoginRequestModel({
    this.email,
    this.password,
  });

  factory UserLoginRequestModel.fromMap(Map<String, dynamic> json) =>
      _$UserLoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRequestModelToJson(this);
}
