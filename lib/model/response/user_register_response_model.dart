import 'dart:convert';

class UserRegisterResponseModel {
  final bool? error;
  final String? message;

  UserRegisterResponseModel({
    this.error,
    this.message,
  });

  factory UserRegisterResponseModel.fromJson(String str) =>
      UserRegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      UserRegisterResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
      };
}
