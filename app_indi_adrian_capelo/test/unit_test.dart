// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:app_indi_adrian_capelo/src/service/galeria_service.dart';

void main() {
  //TEST PARA VER SI SE CONSUMEN LOS DATOS ESPERADOS
  //miro las 5 primeras galerias
  test('Prueba para ver si se consumen los datos esperados', () async {
    var galeria = await GalleryService.getGalerias();
    expect(galeria[0].nombre, "Babel Arte Contemporáneo ");
    expect(galeria[0].direccion, "Apóstoles, 24");
    expect(galeria[0].codigoPostal, "30001");
    expect(galeria[0].municipio, "Murcia");
    expect(galeria[0].pedania, "MURCIA");
    expect(galeria[0].telefono, "+34 968 21 28 98  /  +34 629 81 46 43");
    expect(galeria[0].email, "info@babelarte.com / ");
    expect(galeria[0].webGaleria, "http://www.babelarte.com");

    expect(galeria[1].nombre, "Bisel");
    expect(galeria[1].direccion, "Plaza del Par, 14");
    expect(galeria[1].codigoPostal, "30001");
    expect(galeria[1].municipio, "Cartagena");
    expect(galeria[1].pedania, "CARTAGENA");
    expect(galeria[1].telefono, "968 503 197");
    expect(galeria[1].email, "info@galeriabiselarte.com");
    expect(galeria[1].webGaleria, "http://www.galeriabiselarte.com");

    expect(galeria[2].nombre, "CHYS");
    expect(galeria[2].direccion, "C/ Trapería, 11, bajo");
    expect(galeria[2].codigoPostal, "30001");
    expect(galeria[2].municipio, "Murcia");
    expect(galeria[2].pedania, "MURCIA");
    expect(galeria[2].telefono, "968 213 412");
    expect(galeria[2].email, "marfdc@hotmail.com");

    expect(galeria[3].nombre, "DETRAS DEL ROLLO");
    expect(galeria[3].direccion, "C/ Torre del Romo 8");
    expect(galeria[3].codigoPostal, "30002");
    expect(galeria[3].municipio, "Murcia");
    expect(galeria[3].pedania, "MURCIA");
    expect(galeria[3].telefono, "968 225 548");
    expect(galeria[3].email, "laura@angiemeca.com");
    expect(galeria[3].webGaleria, "http://www.detrasdelrollo.com");

    expect(galeria[4].nombre, "EFE SERRANO");
    expect(galeria[4].direccion, "C/ San Sabastián 20");
    expect(galeria[4].codigoPostal, "30503");
    expect(galeria[4].municipio, "Cieza");
    expect(galeria[4].pedania, "CIEZA");
    expect(galeria[4].telefono, "968 455 281");
    expect(galeria[4].email, "reservas@gnkgolf.com");
    expect(galeria[4].webGaleria, "http://www.galeriaefeserrano.com");
  });
}
