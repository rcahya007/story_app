import 'dart:convert';

class UserLoginRequestModel {
  final String? email;
  final String? password;

  UserLoginRequestModel({
    this.email,
    this.password,
  });

  factory UserLoginRequestModel.fromJson(String str) =>
      UserLoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLoginRequestModel.fromMap(Map<String, dynamic> json) =>
      UserLoginRequestModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
