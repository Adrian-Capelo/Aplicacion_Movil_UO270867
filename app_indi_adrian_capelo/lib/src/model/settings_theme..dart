import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTheme {
  //Instancia necesaria para las preferencias del usuario sobre el tema
  static SharedPreferences? _preferences;
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // Devuelve el tema preferido del usuario
  static ThemeMode getThemeMode(SharedPreferences preferences) {
    if (_preferences == null) {
      getSharedPreferences().then((value) => _preferences = value);
    }
    var theme = preferences.getString('theme');
    if (theme == "dark") {
      return ThemeMode.light;
    } else if (theme == "light") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  // Sobreescribe el tema preferido del usuario si se modifica
  static Future setThemeMode(ThemeMode theme) async =>
      await _preferences!.setString("theme", theme.name);
}
