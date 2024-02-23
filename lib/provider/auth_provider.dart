import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/core/variables.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/request/user_login_request_model.dart';
import 'package:story_app/model/request/user_register_request_model.dart';
import 'package:story_app/model/response/user_login_response_model.dart';
import 'package:story_app/model/response/user_register_response_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();
    final logout = await authRepository.logout();
    if (logout) {
      await authRepository.deleteUser();
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogout = false;
    notifyListeners();
    return !isLoggedIn;
  }

  // Edited
  // Register
  Future<UserRegisterResponseModel> register(
      UserRegisterRequestModel user) async {
    isLoadingRegister = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('${Variables.urlBase}/register'),
      body: user.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      isLoadingRegister = false;
      notifyListeners();
      return UserRegisterResponseModel.fromJson(response.body);
    } else {
      isLoadingRegister = false;
      notifyListeners();
      return UserRegisterResponseModel.fromJson(response.body);
    }
  }

  // Login
  Future<UserLoginResponseModel> login(UserLoginRequestModel user) async {
    isLoadingLogin = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('${Variables.urlBase}/login'),
      body: user.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      await authRepository.login();
      await authRepository
          .saveUser(UserLoginResponseModel.fromJson(response.body));
      isLoadingLogin = false;
      notifyListeners();
      return UserLoginResponseModel.fromJson(response.body);
    } else {
      isLoadingLogin = false;
      notifyListeners();
      return UserLoginResponseModel.fromJson(response.body);
    }
  }
}
