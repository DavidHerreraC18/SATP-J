import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'dialogo_consentimiento_principal.dart';

class RegisterPage1 extends StatefulWidget {
  static const route = '/perfil-documentos-1';

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: toolbarInicio(context),
        body: Theme(
            data: temaFormularios(),
            child: DefaultTabController(
                length: 3,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Card(
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
                                child: Container(child: NombrePaciente()),
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
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Documentos",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Horario",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ])),
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
                                      DatosPaciente(),
                                      DocumentosPaciente(),
                                      Icon(Icons.directions_bike),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ],
                ))));
  }
}

class DatosPaciente extends StatefulWidget {
  @override
  DatosPacienteState createState() {
    return DatosPacienteState();
  }
}

class DatosPacienteState extends State<DatosPaciente> {
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
                  child: Text(
                    "Información",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
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
                              "CC:",
                              "1029311221",
                              Icon(FontAwesome.address_card,
                                  size: 20.0, color: kPrimaryColor))),
                      Flexible(
                          child: _containerDatos(
                              "Edad: ",
                              "31 años",
                              Icon(Icons.person,
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
                              "+(57)323232323",
                              "",
                              Icon(Icons.phone,
                                  size: 20.0, color: kPrimaryColor))),
                      Flexible(
                          child: _containerDatos(
                              "pepitoflorezquintero@javeriana.edu.co",
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
                              "Dirección: ",
                              "Av. 3303 # 33-00",
                              Icon(Icons.house,
                                  size: 20.0, color: kPrimaryColor))),
                      Flexible(
                          child: _containerDatos(
                              "Estrato: ",
                              "3",
                              Icon(Entypo.circular_graph,
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
                      _containerDatos("Terapeuta: ", "Aun no asignado",
                          Icon(Icons.people, size: 20.0, color: kPrimaryColor))
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
            Divider(height: 1),
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
              title: Text(texto + datoUsuario,
                  style: TextStyle(
                      height: 1.1, fontSize: 16, color: Colors.black)),
              leading: icono));
}

class DocumentosPaciente extends StatefulWidget {
  @override
  DocumentosPacienteState createState() {
    return DocumentosPacienteState();
  }
}

class DocumentosPacienteState extends State<DocumentosPaciente> {
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
                  child: Text(
                    "Documentos",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 25.0),
              child: Container(
                  height: 20,
                  width: 700,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 125, maxWidth: 500),
                            width: 500,
                            child: ListTile(
                                title: Text("Documento de Identidad",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 16,
                                        color: Colors.black)),
                                leading: Icon(FontAwesome.address_card,
                                    size: 20.0, color: kPrimaryColor))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: ElevatedButton(
                            child: Text("Subir"), onPressed: () {}),
                      ),
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
                        child: Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 125, maxWidth: 500),
                            width: 500,
                            child: ListTile(
                                title: Text("Consentimiento Informado",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 16,
                                        color: Colors.black)),
                                leading: Icon(Ionicons.md_document,
                                    size: 23.0, color: kPrimaryColor))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: DialogoConsentimientoPrincipal(),
                      ),
                    ],
                  )),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 25.0),
              child: Container(
                  height: 20,
                  width: 900,
                  //alignment: Alignment.center,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 125, maxWidth: 500),
                            width: 500,
                            child: ListTile(
                                title: Text(
                                    "Consentimiento Informado Telepsicología",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 16,
                                        color: Colors.black)),
                                leading: Icon(Ionicons.md_document,
                                    size: 23.0, color: kPrimaryColor))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: ElevatedButton(
                            child: Text("Subir"), onPressed: () {}),
                      ),
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
                        child: Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 125, maxWidth: 500),
                            width: 500,
                            child: ListTile(
                                title: Text("Recibo de Servicio Público",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 16,
                                        color: Colors.black)),
                                leading: Icon(Ionicons.md_document,
                                    size: 23.0, color: kPrimaryColor))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: ElevatedButton(
                            child: Text("Subir"), onPressed: () {}),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}

class NombrePaciente extends StatefulWidget {
  @override
  NombrePacienteState createState() {
    return NombrePacienteState();
  }
}

class NombrePacienteState extends State<NombrePaciente> {
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
                    Text("Pepito Alejandro Maracaibo",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("Paciente",
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
