import 'dart:async';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_editar_paciente.dart';

class VistaPerfilPaciente extends StatefulWidget {
  static const route = '/perfil-paciente';
  VistaPerfilPaciente({Key key}) : super(key: key);

  @override
  _VistaPerfilPacienteState createState() => _VistaPerfilPacienteState();
}

class _VistaPerfilPacienteState extends State<VistaPerfilPaciente> {
  Paciente pacienteActual;
  @override
  initState() {
    super.initState();
  }

  Future<String> obtenerPaciente() async {
    String uid = ProviderAuntenticacion.uid;
    pacienteActual = await ProviderAdministracionPacientes.buscarPaciente(uid);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerPaciente(), // function where you call your api
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
                appBar: toolbarPaciente(context),
                body: Theme(
                    data: temaFormularios(),
                    child: DefaultTabController(
                        length: 2,
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
                                              child: NombrePaciente(
                                            pacienteActual: this.pacienteActual,
                                          )),
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
                                              Container(
                                                height: 30,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Documentos",
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
                                              DatosPaciente(
                                                pacienteActual:
                                                    this.pacienteActual,
                                              ),
                                              DocumentosPaciente(
                                                pacienteActual:
                                                    this.pacienteActual,
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

class DatosPaciente extends StatefulWidget {
  final Paciente pacienteActual;
  DatosPaciente({this.pacienteActual});
  @override
  DatosPacienteState createState() {
    return DatosPacienteState(pacienteActual);
  }
}

class DatosPacienteState extends State<DatosPaciente> {
  Paciente pacienteActual;
  Practicante practicanteActual;
  DatosPacienteState(Paciente paciente) {
    this.pacienteActual = paciente;
  }
  @override
  void initState() {
    super.initState();
  }

  Future<String> obtenerPracticanteActual() async {
    this.practicanteActual =
        await ProviderAdministracionPacientes.traerPracticanteActivoPaciente(
            pacienteActual.id);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerPracticanteActual(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
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
                                      pacienteActual.tipoDocumento,
                                      pacienteActual.documento,
                                      Icon(FontAwesome.address_card,
                                          size: 20.0, color: kPrimaryColor))),
                              Flexible(
                                  child: _containerDatos(
                                      "Edad: ",
                                      pacienteActual.edad.toString() + "años",
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
                                      pacienteActual.telefono,
                                      "",
                                      Icon(Icons.phone,
                                          size: 20.0, color: kPrimaryColor))),
                              Flexible(
                                  child: _containerDatos(
                                      pacienteActual.email,
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
                                      pacienteActual.direccion,
                                      Icon(Icons.house,
                                          size: 20.0, color: kPrimaryColor))),
                              Flexible(
                                  child: _containerDatos(
                                      "Estrato: ",
                                      pacienteActual.estrato.toString(),
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
                              _containerDatos(
                                  "Terapeuta: ",
                                  practicanteActual.nombre +
                                      " " +
                                      practicanteActual.apellido,
                                  Icon(Icons.people,
                                      size: 20.0, color: kPrimaryColor))
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 30.0, // you can adjust the width as you need
                          child: IconButton(
                              icon: Icon(Icons.edit),
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, VistaEditarPaciente.route);
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 30.0, // you can adjust the width as you need
                          child: IconButton(
                              icon: Icon(Icons.vpn_key),
                              color: kPrimaryColor,
                              onPressed: () {
                                ProviderAuntenticacion.sendChangePasswordEmail(
                                    widget.pacienteActual.email);
                              }),
                        ),
                      ],
                    ),
                  ],
                )); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
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
  final Paciente pacienteActual;
  DocumentosPaciente({this.pacienteActual});

  @override
  DocumentosPacienteState createState() {
    return DocumentosPacienteState(pacienteActual);
  }
}

class DocumentosPacienteState extends State<DocumentosPaciente> {
  Paciente pacienteActual;

  DocumentosPacienteState(Paciente paciente) {
    this.pacienteActual = paciente;
  }

  Uint8List _consentimientoPrincipal;
  Uint8List _consentimientoTP;
  bool _isConsentimientoEntered = false;
  bool _isConsentimientoTPEntered = false;

  funcionConsentimientoTP(Uint8List _consentimientoTP) {
    this._consentimientoTP = _consentimientoTP;
    setState(() {
      _isConsentimientoTPEntered = true;
    });
  }

  funcionConsentimientoP(Uint8List _consentimientoPrincipal) {
    this._consentimientoPrincipal = _consentimientoPrincipal;
    setState(() {
      _isConsentimientoEntered = true;
    });
  }

  @override
  initState() {
    super.initState();
  }

  Future<String> traerDocumentos() async {
    List<DocumentoPaciente> documentos =
        await ProviderAdministracionPacientes.traerDocumentosPaciente(
            pacienteActual);
    if (documentos.isNotEmpty) {
      setState(() {
        for (int i = 0; i < documentos.length; i++) {
          print(documentos[i].tipo);
          if (documentos[i].tipo == "ConsentimientoPrincipal") {
            _consentimientoPrincipal =
                Base64Codec().decode(documentos[i].contenido);
            _isConsentimientoEntered = true;
          } else if (documentos[i].tipo == "ConsentimientoTP") {
            _consentimientoTP = Base64Codec().decode(documentos[i].contenido);
            _isConsentimientoTPEntered = true;
          }
        }
      });
    }
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: traerDocumentos(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Container(
                height: 200,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 5.0,
                                  left: 5.0,
                                  top: 0.0,
                                  bottom: 10.0),
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
                                width: 900,
                                //alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 20.0,
                                          constraints: BoxConstraints(
                                              minWidth: 125, maxWidth: 500),
                                          width: 500,
                                          child: ListTile(
                                              title: Text(
                                                  "Consentimiento Informado",
                                                  style: TextStyle(
                                                      height: 1.1,
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              leading: Icon(
                                                  Ionicons.md_document,
                                                  size: 23.0,
                                                  color: kPrimaryColor))),
                                    ),
                                    _isConsentimientoEntered
                                        ? Container(
                                            height: 20,
                                            width: 100,
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: kPrimaryColor,
                                              child: MaterialButton(
                                                  onPressed: () async {
                                                    List<int> bytes =
                                                        _consentimientoPrincipal
                                                            .toList();
                                                    await FileSaveHelper
                                                        .saveAndLaunchFile(
                                                            bytes,
                                                            'Consentimiento Informado.pdf');
                                                  },
                                                  child: Text(
                                                    "Visualizar",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 23,
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
                                          constraints: BoxConstraints(
                                              minWidth: 125, maxWidth: 500),
                                          width: 500,
                                          child: ListTile(
                                              title: Text(
                                                  "Consentimiento Informado Telepsicología",
                                                  style: TextStyle(
                                                      height: 1.1,
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              leading: Icon(
                                                  Ionicons.md_document,
                                                  size: 23.0,
                                                  color: kPrimaryColor))),
                                    ),
                                    _isConsentimientoTPEntered
                                        ? Container(
                                            height: 20,
                                            width: 100,
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: kPrimaryColor,
                                              child: MaterialButton(
                                                  onPressed: () async {
                                                    List<int> bytes =
                                                        _consentimientoTP
                                                            .toList();
                                                    await FileSaveHelper
                                                        .saveAndLaunchFile(
                                                            bytes,
                                                            'Consentimiento Informado Telepsicologia.pdf');
                                                  },
                                                  child: Text(
                                                    "Visualizar",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 23,
                                          ),
                                  ],
                                )),
                          ),
                        ])
                  ],
                )); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}

class NombrePaciente extends StatefulWidget {
  final Paciente pacienteActual;
  NombrePaciente({this.pacienteActual});

  @override
  NombrePacienteState createState() {
    return NombrePacienteState(this.pacienteActual);
  }
}

class NombrePacienteState extends State<NombrePaciente> {
  Paciente pacienteActual;

  NombrePacienteState(Paciente paciente) {
    this.pacienteActual = paciente;
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
                    Text(pacienteActual.nombre + " " + pacienteActual.apellido,
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
