import 'dart:async';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/auxiliar_administrativo/auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_auxiliares.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:flutter_icons/flutter_icons.dart';

class VistaPerfilAuxiliar extends StatefulWidget {
  static const route = '/perfil-auxiliar';
  VistaPerfilAuxiliar({Key key}) : super(key: key);

  @override
  _VistaPerfilAuxiliarState createState() => _VistaPerfilAuxiliarState();
}

class _VistaPerfilAuxiliarState extends State<VistaPerfilAuxiliar> {
  AuxiliarAdministrativo auxiliarActual;
  @override
  initState() {
    super.initState();
  }

  Future<String> obtenerAuxiliar() async {
    String uid = ProviderAuntenticacion.uid;
    auxiliarActual = await ProviderAdministracionAuxiliares.buscarAuxiliar(uid);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerAuxiliar(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: toolbarAuxiliarAdministrativo(context),
                body: Theme(
                    data: temaFormularios(),
                    child: DefaultTabController(
                        length: 1,
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 1100,
                                  child: Card(
                                      margin: EdgeInsets.only(
                                          right: 80.0,
                                          left: 80.0,
                                          top: 20.0,
                                          bottom: 25.0),
                                      elevation: 25.0,
                                      child: Column(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 20.0,
                                              left: 20.0,
                                              top: 20.0,
                                              bottom: 0.0),
                                          child: Container(
                                              child: NombreAuxiliar(
                                                  auxiliarActual:
                                                      this.auxiliarActual)),
                                        ),
                                        Divider(),
                                        Container(
                                          child: TabBar(
                                            isScrollable: true,
                                            tabs: [
                                              Container(
                                                height: 30,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Información",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ])),
                                ),
                                Card(
                                    margin: EdgeInsets.only(
                                        right: 50.0,
                                        left: 50.0,
                                        top: 20.0,
                                        bottom: 20.0),
                                    elevation: 25.0,
                                    child: Column(children: [
                                      Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Container(
                                          width: 900,
                                          height: 300,
                                          child: TabBarView(
                                            children: [
                                              DatosAuxiliar(
                                                auxiliarActual:
                                                    this.auxiliarActual,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])),
                              ],
                            ),
                          ],
                        )))); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}

class DatosAuxiliar extends StatefulWidget {
  final AuxiliarAdministrativo auxiliarActual;
  DatosAuxiliar({this.auxiliarActual});
  @override
  DatosAuxiliarState createState() {
    return DatosAuxiliarState(auxiliarActual);
  }
}

class DatosAuxiliarState extends State<DatosAuxiliar> {
  AuxiliarAdministrativo auxiliarActual;

  DatosAuxiliarState(AuxiliarAdministrativo auxiliar) {
    this.auxiliarActual = auxiliar;
  }
  @override
  void initState() {
    if (auxiliarActual == null) auxiliarActual = new AuxiliarAdministrativo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    right: 5.0, left: 5.0, top: 0.0, bottom: 10.0),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Información",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.vpn_key),
                                color: kPrimaryColor,
                                onPressed: () {
                                  ProviderAuntenticacion
                                      .sendChangePasswordEmail(
                                          widget.auxiliarActual.email);
                                }),
                            IconButton(
                                icon: Icon(Icons.edit),
                                color: kPrimaryColor,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, VistaEditarAuxiliar.route);
                                }),
                          ],
                        )
                      ]),
                )),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 25.0),
              child: Container(
                  height: 20,
                  width: 700,
                  //alignment: Alignment.center,
                  child: Row(
                    children: [
                      Flexible(
                          child: _containerDatos(
                              auxiliarActual.tipoDocumento + ": ",
                              auxiliarActual.documento,
                              Icon(FontAwesome.address_card,
                                  size: 20.0, color: kPrimaryColor))),
                      Flexible(
                          child: _containerDatos(
                              auxiliarActual.email,
                              "",
                              Icon(Icons.email,
                                  size: 20.0, color: kPrimaryColor))),
                    ],
                  )),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 25.0),
              child: Container(
                  height: 20,
                  width: 700,
                  //alignment: Alignment.center,
                  child: Row(
                    children: [
                      Flexible(
                          child: _containerDatos(
                              auxiliarActual.telefono,
                              "",
                              Icon(Icons.phone,
                                  size: 20.0, color: kPrimaryColor))),
                    ],
                  )),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 25.0),
              child: Container(
                  height: 20,
                  width: 700,
                  //alignment: Alignment.center,
                  child: Row(
                    children: [
                      Flexible(
                          child: _containerDatos(
                              "Dirección: ",
                              auxiliarActual.direccion != null
                                  ? auxiliarActual.direccion
                                  : 'No tiene',
                              Icon(Icons.house,
                                  size: 20.0, color: kPrimaryColor))),
                    ],
                  )),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 20.0),
              child: Container(
                  height: 20,
                  width: 700,
                  //alignment: Alignment.center,
                  child: Row(
                    children: [
                      _containerDatos(
                          "Riesgo Epidemiológico: ",
                          "Bajo",
                          Icon(FontAwesome.header,
                              size: 15.0, color: kPrimaryColor))
                    ],
                  )),
            ),
          ],
        ));
  }

  Container _containerDatos(String texto, String datoUsuario, Icon icono) =>
      Container(
          alignment: Alignment.center,
          height: 20.0,
          constraints: BoxConstraints(minWidth: 125, maxWidth: 350),
          width: 350,
          child: ListTile(
              title: Text(texto + (datoUsuario != null ? datoUsuario : ''),
                  style: TextStyle(
                      height: 1.1, fontSize: 16, color: Colors.black)),
              leading: icono));
}

class NombreAuxiliar extends StatefulWidget {
  final AuxiliarAdministrativo auxiliarActual;
  NombreAuxiliar({this.auxiliarActual});

  @override
  NombreAuxiliarState createState() {
    return NombreAuxiliarState(this.auxiliarActual);
  }
}

class NombreAuxiliarState extends State<NombreAuxiliar> {
  AuxiliarAdministrativo auxiliarActual;

  NombreAuxiliarState(AuxiliarAdministrativo auxiliar) {
    this.auxiliarActual = auxiliar;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            child: Image.asset(
              'lib/src/utils/images/logo_plataforma.png',
              fit: BoxFit.cover,
              height: 100,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          VerticalDivider(),
          Flexible(
            child: Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text(" "),
                    Text(auxiliarActual.nombre + " " + auxiliarActual.apellido,
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("Auxiliar Administrativo",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    //Text(" "),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
