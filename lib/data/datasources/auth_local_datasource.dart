import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/model/response/user_login_response_model.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(UserLoginResponseModel authUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'auht_data',
      authUser.toJson(),
    );
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auht_data');
  }

  Future<UserLoginResponseModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auht_data');
    if (authData != null) {
      return UserLoginResponseModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auht_data');
    if (authData != null) {
      return true;
    } else {
      return false;
    }
  }
}
