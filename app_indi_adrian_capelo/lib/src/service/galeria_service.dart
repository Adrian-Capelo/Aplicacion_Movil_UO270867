import 'dart:convert';
import 'package:app_indi_adrian_capelo/src/model/galerias_datos.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  //Consumimos los datos del JSON
  static const String datos =
      'https://adrian-capelo.github.io/GaleriasdeArte.json';

  // Lista de objetos donde se carga la respuesta de la peticion GET que se realiza a continuación
  static List<Galerias> gallery = [];

  // Petición GET
  static Future<List<Galerias>> getGalerias() async {
    var response = await http.get(Uri.parse(datos));

    if (response.statusCode != 200) {
      return [];
    }
    // Parsea el JSON al formato definido en el model (galerias_datos.dart)
    GalleryService.gallery =
        Galerias.recorrer_datos_galeria(json.decode(response.body));

    return GalleryService.gallery;
  }

// Método para recorrer los datos de cada galeria
  static Future<List<Galerias>> getDatosGaleria(Galerias galeria) async {
    List<Galerias> lista = [];
    lista.add(galeria);
    return lista;
  }
}
