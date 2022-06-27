import 'package:app_indi_adrian_capelo/src/model/galerias_datos.dart';
import 'package:app_indi_adrian_capelo/src/service/galeria_service.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
import '../view/settings_view.dart';
import 'galeria_item_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

/// Displays a list of SampleItems.
class GaleriasItemListView extends StatefulWidget {
  const GaleriasItemListView({
    Key? key,
  }) : super(key: key);

  @override
  State<GaleriasItemListView> createState() => _GaleriasState();

  static const routeName = '/';
}

// Clase para poder controlar los filtros
class SelectedListController extends GetxController {
  final _selectedList = List<String>.empty(growable: true).obs;
  getSelectedList() => _selectedList;
  setSelectedList(List<String> list) => _selectedList.value = list;
}

class _GaleriasState extends State<GaleriasItemListView> {
  // Lista de las galerias del JSON
  List<Galerias> list = [];

  // Lista que recibe los datos del JSON (galerias)
  List<dynamic> listDynamic = [];

  // Variable para buscar por nombre en la lista de galerias
  String buscar = "";

  List<String> defaultList = [
    "Cieza",
    "Cartagena",
    "Murcia",
  ];

  var handlerList = Get.put(SelectedListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: <Widget>[
              Container(
                // MediaQuery devuelve el ancho de la pantalla, tanto portrait como landscape
                width: MediaQuery.of(context).size.width - 96,
                margin: const EdgeInsets.only(
                    bottom: 8, top: 8, left: 12, right: 8),
                // TextField para buscar por nombre o direccion
                child: TextField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Buscar",
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                    onChanged: (value) {
                      buscar = value;
                      buscarGaleriaPorNombre(buscar);
                    }),
              ),
              // Boton para aplicar los filtros por distrito o etiqueta
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegacion a la ventana de ajustes, recuperando el contexto
              // (posicion en la lista en la que se encontraba el usuario)
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              // Crea la ListView
              child: GaleriaWidget()),
          FloatingActionButton.extended(
              icon: const Icon(Icons.filter),
              onPressed: () => openFilterDialog(context),
              label: const Text('Filtrar por municipio'),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GaleriaWidget() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return FutureBuilder(
            // Cargar desde cache la lista
            future: loadCache(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Construir el ListView con su propio Builder
                return ListView.builder(
                  shrinkWrap: true,
                  restorationId: 'sampleItemListView',
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = list[index];
                    return ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 100,
                            minHeight: 550,
                            maxWidth: 104,
                            maxHeight: 551,
                          ),
                          child: Image.asset(
                            item.foto,
                            width: 100,
                          ),
                        ),
                        title: Text(item.nombre),
                        subtitle: Text(item.direccion),
                        onTap: () {
                          // Navegacion a la ventana de detalle de cada galeria de la lista
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GaleriaItemDetailsView(galeria: item)));
                        });
                  },
                );
              } else if (snapshot.hasError) {
                // En caso de error
                return Text(snapshot.error.toString());
              } else {
                return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                      Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            // Abstraccion de carga con un CircularProgressIndicator
                            child: CircularProgressIndicator(),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      )
                    ]));
              }
            });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Inicializar el listado de galerias
    list.addAll(GalleryService.gallery);
    //filtrando por nombre
    buscarGaleriaPorNombre(buscar);
  }

  // Carga de la cache
  Future<List<Galerias>> loadCache() async {
    listDynamic = await GalleryService.getGalerias();
    return GalleryService.getGalerias();
  }

  void buscarGaleriaPorNombre(String aux) {
    List<Galerias> listaInicial = [];
    List<Galerias> listaFinal = [];
    // Filtrar según se escriba nombre, dirección, municipio o CP
    listaInicial.addAll(GalleryService.gallery);
    if (aux.isNotEmpty) {
      for (var galeria in listaInicial) {
        if (galeria.nombre.toLowerCase().contains(aux.toLowerCase()) ||
            galeria.direccion.toLowerCase().contains(aux.toLowerCase()) ||
            galeria.municipio.toLowerCase().contains(aux.toLowerCase()) ||
            galeria.pedania.toLowerCase().contains(aux.toLowerCase()) ||
            galeria.codigoPostal.toLowerCase().contains(aux.toLowerCase())) {
          listaFinal.add(galeria);
        }
      }
      // Actualizar la lista
      setState(() {
        list.clear();
        list.addAll(listaFinal);
      });
    }
    // Restablecer lista inicial si no se usa el filtro
    else {
      setState(() {
        list.clear();
        list.addAll(listaInicial);
      });
    }
  }

  // Dialogo del filtro
  void openFilterDialog(context) async {
    await FilterListDialog.display<String>(context,
        listData: defaultList,
        selectedListData: handlerList.getSelectedList(),
        headlineText: AppLocalizations.of(context)!.filtro,
        choiceChipLabel: (item) => item,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (list, text) {
          return list.toLowerCase().contains(text.toLowerCase());
        },
        onApplyButtonClick: (button) {
          setState(() {
            handlerList.setSelectedList(button!);
          });
          list.clear();
          for (var galeria in GalleryService.gallery) {
            for (var selectedList in handlerList.getSelectedList()) {
              if ((galeria.municipio == selectedList)) {
                list.add(galeria);
              }
            }
          }
        });
  }
}
