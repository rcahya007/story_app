import 'package:flutter/material.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  Future<bool> login(UserModel user) async {
    isLoadingLogin = true;
    notifyListeners();
    final userState = await authRepository.getUser();
    if (userState == null) {
      isLoadingLogin = false;
      notifyListeners();
      return false;
    }
    if (user.email == userState.email && user.password == userState.password) {
      await authRepository.login();
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogin = false;
    notifyListeners();
    return isLoggedIn;
  }

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

  Future<bool> saveUser(UserModel user) async {
    isLoadingRegister = true;
    notifyListeners();
    final userState = await authRepository.saveUser(user);
    isLoadingRegister = false;
    notifyListeners();
    return userState;
  }
}
