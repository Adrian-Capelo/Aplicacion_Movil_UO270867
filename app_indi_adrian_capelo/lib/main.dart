import 'package:app_indi_adrian_capelo/src/model/galerias_datos.dart';
import 'package:app_indi_adrian_capelo/src/service/galeria_service.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/controller/settings_controller.dart';
import 'src/service/settings_service.dart';

void main() async {
  //Inicializar controller
  final settingsController = SettingsController(SettingsService());

  //Cargar tema preferido del usuario
  await settingsController.loadSettings();

  //Devuelve las galerías para iniciar la aplicación
  List<Galerias> galerias = await GalleryService.getGalerias();

  //Ejecución de la aplicación pasando el controller y las galerias
  runApp(MyApp(settingsController: settingsController, galeria: galerias[0]));
}
