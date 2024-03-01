import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalLanguageDatasource {
  Future<void> saveLanguange(Locale language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languange', language.toString());
  }

  Future<Locale?> getLocalLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('languange');
    if (language != null) {
      return Locale(language);
    } else {
      return const Locale('id');
    }
  }
}
