import 'dart:convert';

class UserRegisterRequestModel {
  final String? name;
  final String? email;
  final String? password;

  UserRegisterRequestModel({
    this.name,
    this.email,
    this.password,
  });

  factory UserRegisterRequestModel.fromJson(String str) =>
      UserRegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      UserRegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
