import 'package:json_annotation/json_annotation.dart';

part 'user_login_response_model.g.dart';

@JsonSerializable()
class UserLoginResponseModel {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  UserLoginResponseModel({
    this.error,
    this.message,
    this.loginResult,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseModelToJson(this);
}

@JsonSerializable()
class LoginResult {
  final String? userId;
  final String? name;
  final String? token;

  LoginResult({
    this.userId,
    this.name,
    this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
