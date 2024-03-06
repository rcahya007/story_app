import 'package:json_annotation/json_annotation.dart';

part 'user_register_response_model.g.dart';

@JsonSerializable()
class UserRegisterResponseModel {
  final bool? error;
  final String? message;

  UserRegisterResponseModel({
    this.error,
    this.message,
  });

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterResponseModelToJson(this);
}
