import 'dart:convert';

import 'package:story_app/core/constants/variables.dart';
import 'package:story_app/data/model/request/user_login_request_model.dart';
import 'package:story_app/data/model/request/user_register_request_model.dart';
import 'package:story_app/data/model/response/user_login_response_model.dart';
import 'package:story_app/data/model/response/user_register_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, UserRegisterResponseModel>> register(
      UserRegisterRequestModel user) async {
    final response = await http.post(
      Uri.parse('${Variables.urlBase}/register'),
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return Right(
        UserRegisterResponseModel.fromJson(jsonDecode(response.body)),
      );
    } else {
      return Left(UserRegisterResponseModel.fromJson(jsonDecode(response.body))
          .message!);
    }
  }

  Future<Either<String, UserLoginResponseModel>> login(
    UserLoginRequestModel user,
  ) async {
    final response = await http.post(Uri.parse('${Variables.urlBase}/login'),
        body: jsonEncode(user.toJson()),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      return Right(UserLoginResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(
          UserLoginResponseModel.fromJson(jsonDecode(response.body)).message!);
    }
  }
}
