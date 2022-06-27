import 'package:flutter/material.dart';
import '../model/settings_theme..dart';

class SettingsService {
  //Cargar el tema elegido por el usuario
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  // Mantener las preferencias del tema elegido por el usuario
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    SettingTheme.setThemeMode(theme);
  }
}
