import 'package:json_annotation/json_annotation.dart';

part 'user_register_request_model.g.dart';

@JsonSerializable()
class UserRegisterRequestModel {
  final String? name;
  final String? email;
  final String? password;

  UserRegisterRequestModel({
    this.name,
    this.email,
    this.password,
  });

  factory UserRegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      _$UserRegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterRequestModelToJson(this);
}
