import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/model/response/user_login_response_model.dart';

class AuthRepository {
  final String stateKey = 'state';
  final String userKey = "user";

  // STATE
  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, false);
  }

  // USER
  Future<bool> saveUser(UserLoginResponseModel user) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, user.toJson());
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, "");
  }

  Future<UserLoginResponseModel?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final json = preferences.getString(userKey) ?? "";
    UserLoginResponseModel? user;
    try {
      user = UserLoginResponseModel.fromJson(json);
    } catch (e) {
      user = null;
    }
    return user;
  }
}
