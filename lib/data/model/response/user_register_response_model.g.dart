// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterResponseModel _$UserRegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserRegisterResponseModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UserRegisterResponseModelToJson(
        UserRegisterResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
