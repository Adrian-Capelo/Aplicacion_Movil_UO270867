import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/settings_service.dart';

// Para guardar preferencias del tema elegido por el usuario
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  //instacia de las preferencias del usuario
  final SettingsService _settingsService;

  // parámetro para guardar el tema prefereido del usuario
  late ThemeMode _themeMode;

  // Inicializar parámetro
  ThemeMode get themeMode => _themeMode;

  // Cargar la configuración elegida
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    notifyListeners();
  }

  //Actualización y permanencia de la opción elegida por el usuario
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    // Actualizar tema
    _themeMode = newThemeMode;
    notifyListeners();

    //Para guardar la elección
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
