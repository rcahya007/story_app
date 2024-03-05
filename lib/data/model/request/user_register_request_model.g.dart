// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterRequestModel _$UserRegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    UserRegisterRequestModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserRegisterRequestModelToJson(
        UserRegisterRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
