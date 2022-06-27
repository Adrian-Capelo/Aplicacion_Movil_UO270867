// ignore_for_file: prefer_const_constructors

import 'package:app_indi_adrian_capelo/src/model/galerias_datos.dart';
import 'package:flutter/material.dart';
import 'package:app_indi_adrian_capelo/src/service/galeria_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Displays detailed information about a SampleItem.
class GaleriaItemDetailsView extends StatelessWidget {
  const GaleriaItemDetailsView({Key? key, required this.galeria})
      : super(key: key);

  final Galerias galeria;
  static const routeName = '/sample_item';

  void launchUrl(BuildContext context, String url) async {
    try {
      // ignore: deprecated_member_use
      await launch(url);
    } catch (platformException) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.codigoPostal,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Google maps
    List<Marker> marks = [];

    marks.add(Marker(
        markerId: MarkerId(galeria.nombre),
        position: LatLng(
            double.parse(galeria.latitud), double.parse(galeria.longitud)),
        infoWindow: InfoWindow(title: galeria.direccion)));

    return Scaffold(
        appBar: AppBar(
          title: Text(galeria.nombre),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return horizontal_vertical_View(
              context, marks, orientation == Orientation.portrait);
        }));
  }

  Widget horizontal_vertical_View(
      BuildContext context, List<Marker> marks, bool isPortrait) {
    if (isPortrait) {
      // Layout para posicion vertical
      return SingleChildScrollView(
          child: Column(children: [
        // Muestra la imagen y el detail Widget con el ancho completo
        Image.asset(galeria.foto),
        informationGaleriaWidget(
            context, marks, MediaQuery.of(context).size.width)
      ]));
    } else {
      // Layout para posicion horizontal
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Muestra la imagen a la izquierda
          Image.asset(galeria.foto,
              width: MediaQuery.of(context).size.width / 2),
          // Muestra el detail Widget con la mitad del ancho a la derecha
          SingleChildScrollView(
            child: informationGaleriaWidget(
                context, marks, MediaQuery.of(context).size.width / 2),
          )
        ],
      );
    }
  }

  Widget informationGaleriaWidget(
      BuildContext context, List<Marker> marks, double width) {
    // El entero que se resta en el atributo width es el padding aplicado
    return Column(children: [
      SizedBox(
        width: width - 36,
        child: Html(data: AppLocalizations.of(context)!.titulo, style: {
          "body": Style(
            textAlign: TextAlign.justify,
            fontSize: FontSize.large,
            margin: const EdgeInsets.all(9.0),
          )
        }),
      ),
      Text(
        AppLocalizations.of(context)!.direccion,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.direccion, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.email,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.email, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.codigoPostal,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.codigoPostal, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.municipio,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.municipio, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.pedania,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.pedania, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.contacto,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.telefono, style: TextStyle(color: Colors.blue)),
      Text(
        AppLocalizations.of(context)!.web,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(galeria.webGaleria, style: TextStyle(color: Colors.blue)),
      SizedBox(
        width: width - 36,
        child: Html(data: AppLocalizations.of(context)!.botones, style: {
          "body": Style(
              textAlign: TextAlign.justify,
              fontSize: FontSize.large,
              margin: const EdgeInsets.all(9.0))
        }),
      ),
      SizedBox(
        height: 50,
        width: width - 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Boton de llamada en una Row de ancho completo
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width - 48, 45),
                  maximumSize: Size(width - 48, 45)),
              onPressed: () {
                // Al pulsarlo, copia el numero de telefono al dialer para llamar
                launchUrl(context, 'tel:' + galeria.telefono);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.phone),
                  Text(" " + AppLocalizations.of(context)!.contacto)
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 65,
        width: width - 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Boton de enviar un email con acceso al correo en una Row de medio ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width / 2 - 28, 45),
                  maximumSize: Size(width / 2 - 28, 45)),
              onPressed: () {
                // Al pulsarlo, copia la direccion de correo en el campo del destinatario
                launchUrl(context, 'mailto:' + galeria.email);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.email),
                  Text(" " + AppLocalizations.of(context)!.email,
                      style: const TextStyle(fontSize: 12))
                ],
              ),
            ),
            // Boton de acceder al sitio web
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width / 2 - 28, 45),
                  maximumSize: Size(width / 2 - 28, 45)),
              onPressed: () {
                // Al pulsarlo, redirige a la pagina web indicada por URL
                launchUrl(context, galeria.webGaleria);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.web),
                    Text(" " + AppLocalizations.of(context)!.web)
                  ]),
            ),
          ],
        ),
      ),
      SizedBox(
        width: width - 36,
        child: Html(data: AppLocalizations.of(context)!.mapa, style: {
          "body": Style(
              textAlign: TextAlign.justify,
              fontSize: FontSize.large,
              margin: const EdgeInsets.all(9.0))
        }),
      ),
      Column(
        children: <Widget>[
          SizedBox(
              width: width - 48,
              height: 300.0,
              // Widget de Google Maps
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      // Coordenadas
                      double.parse(galeria.latitud),
                      double.parse(galeria.longitud)),
                  zoom: 15,
                ),
                // Añadir el marcador
                markers: Set<Marker>.of(marks),
              ))
        ],
      ),
    ]);
  }
}
