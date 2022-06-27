import 'package:app_indi_adrian_capelo/src/model/galerias_datos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view/galeria_item_details_view.dart';
import 'view/galeria_item_list_view.dart';
import 'controller/settings_controller.dart';
import 'view/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  //Constructor inicializa controlador y galeria
  const MyApp(
      {Key? key, required this.settingsController, required this.galeria})
      : super(key: key);

  final SettingsController settingsController;
  final Galerias galeria;

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder recibe los cambios del tema del controller
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          //Continuar la actividad después de estar en segundo plano
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          // Internacionalización
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],

          // Titulo de la aplicacion
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          //Definit temas  y asignar preferido del usuario
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Rutas y navegación
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case GaleriaItemDetailsView.routeName:
                    return GaleriaItemDetailsView(galeria: galeria);
                  case GaleriasItemListView.routeName:
                  default:
                    return const GaleriasItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
