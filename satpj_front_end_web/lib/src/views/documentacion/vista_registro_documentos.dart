import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/provider_documentos_paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:satpj_front_end_web/src/views/documentacion/dialogo_consentimiento_telepsicologia.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';

import 'dialogo_consentimiento_principal.dart';

class VistaRegistroDocumentos extends StatefulWidget {
  static const route = '/perfil-documentos';
  VistaRegistroDocumentos({Key key}) : super(key: key);

  @override
  _VistaRegistroDocumentosState createState() =>
      _VistaRegistroDocumentosState();
}

class _VistaRegistroDocumentosState extends State<VistaRegistroDocumentos> {
  Paciente pacienteActual;
  @override
  Future<void> initState() async {
    String uid = ProviderAuntenticacion.uid;
    pacienteActual = await ProviderAdministracionPacientes.buscarPaciente(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: toolbarInicio(context),
        body: Theme(
            data: temaFormularios(),
            child: DefaultTabController(
                length: 2,
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
                                      DatosPaciente(
                                        pacienteActual: this.pacienteActual,
                                      ),
                                      DocumentosPaciente(
                                        pacienteActual: this.pacienteActual,
                                      ),
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
  final Paciente pacienteActual;
  DatosPaciente({this.pacienteActual});
  @override
  DatosPacienteState createState() {
    return DatosPacienteState(pacienteActual);
  }
}

class DatosPacienteState extends State<DatosPaciente> {
  Paciente pacienteActual;

  DatosPacienteState(Paciente paciente) {
    this.pacienteActual = paciente;
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
  Uint8List _reciboPago;
  Uint8List _fotoDocumento;
  bool _isConsentimientoEntered = false;
  bool _isConsentimientoTPEntered = false;
  bool _isReciboPagoEntered = false;
  bool _isFotoDocumentoEntered = false;
  bool _isCompleted = false;

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
  initState() async {
    await traerDocumentos();
    super.initState();
  }

  traerDocumentos() async {
    List<DocumentoPaciente> documentos =
        await ProviderAdministracionPacientes.traerDocumentosPaciente(
            pacienteActual);
    if (documentos.isNotEmpty) {
      setState(() {
        for (int i = 0; i < documentos.length; i++) {
          print(documentos[i].tipo);
          if (documentos[i].tipo == "FotoPerfil") {
            _fotoDocumento = Base64Codec().decode(documentos[i].contenido);
            _isFotoDocumentoEntered = true;
          } else if (documentos[i].tipo == "ConsentimientoPrincipal") {
            _consentimientoPrincipal =
                Base64Codec().decode(documentos[i].contenido);
            _isConsentimientoEntered = true;
          } else if (documentos[i].tipo == "ReciboPago") {
            _fotoDocumento = Base64Codec().decode(documentos[i].contenido);
            _isReciboPagoEntered = true;
          } else if (documentos[i].tipo == "ConsentimientoTP") {
            _consentimientoTP = Base64Codec().decode(documentos[i].contenido);
            _isConsentimientoTPEntered = true;
          }
          _isCompleted = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                constraints: BoxConstraints(
                                    minWidth: 125, maxWidth: 500),
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
                          _isFotoDocumentoEntered
                              ? Icon(
                                  Icons.check,
                                  color: kAccentColor,
                                )
                              : SizedBox(
                                  width: 23,
                                ),
                          Container(
                            height: 20,
                            width: 100,
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              color: kPrimaryColor,
                              child: MaterialButton(
                                  onPressed: () async {
                                    var picked =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                                    );
                                    if (picked != null) {
                                      print(picked
                                          .files.first.bytes.lengthInBytes);
                                      setState(() {
                                        _fotoDocumento =
                                            picked.files.first.bytes;
                                        _isFotoDocumentoEntered = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Subir",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
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
                                    title: Text("Consentimiento Informado",
                                        style: TextStyle(
                                            height: 1.1,
                                            fontSize: 16,
                                            color: Colors.black)),
                                    leading: Icon(Ionicons.md_document,
                                        size: 23.0, color: kPrimaryColor))),
                          ),
                          _isConsentimientoEntered
                              ? Icon(
                                  Icons.check,
                                  color: kAccentColor,
                                )
                              : SizedBox(
                                  width: 23,
                                ),
                          Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 50, maxWidth: 350),
                            width: 100,
                            child: DialogoConsentimientoPrincipal(
                              pacienteActual: pacienteActual,
                              funcionConsentimientoP: funcionConsentimientoP,
                            ),
                          ),
                          _isConsentimientoEntered
                              ? Container(
                                  height: 20,
                                  width: 100,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kPrimaryColor,
                                    child: MaterialButton(
                                        onPressed: () async {
                                          List<int> bytes =
                                              _consentimientoPrincipal.toList();
                                          await FileSaveHelper.saveAndLaunchFile(
                                              bytes,
                                              'Consentimiento Informado.pdf');
                                        },
                                        child: Text(
                                          "Visualizar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                                    leading: Icon(Ionicons.md_document,
                                        size: 23.0, color: kPrimaryColor))),
                          ),
                          _isConsentimientoTPEntered
                              ? Icon(
                                  Icons.check,
                                  color: kAccentColor,
                                )
                              : SizedBox(
                                  width: 23,
                                ),
                          Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            constraints:
                                BoxConstraints(minWidth: 50, maxWidth: 350),
                            width: 100,
                            child: DialogoConsentimientoTelepsicologia(
                                funcionConsentimientoTP, pacienteActual),
                          ),
                          _isConsentimientoTPEntered
                              ? Container(
                                  height: 20,
                                  width: 100,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kPrimaryColor,
                                    child: MaterialButton(
                                        onPressed: () async {
                                          List<int> bytes =
                                              _consentimientoTP.toList();
                                          await FileSaveHelper.saveAndLaunchFile(
                                              bytes,
                                              'Consentimiento Informado Telepsicologia.pdf');
                                        },
                                        child: Text(
                                          "Visualizar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                      width: 700,
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
                                    title: Text("Recibo de Servicio Público",
                                        style: TextStyle(
                                            height: 1.1,
                                            fontSize: 16,
                                            color: Colors.black)),
                                    leading: Icon(Ionicons.md_document,
                                        size: 23.0, color: kPrimaryColor))),
                          ),
                          _isReciboPagoEntered
                              ? Icon(
                                  Icons.check,
                                  color: kAccentColor,
                                )
                              : SizedBox(
                                  width: 23,
                                ),
                          Container(
                            height: 20,
                            width: 100,
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              color: kPrimaryColor,
                              child: MaterialButton(
                                  onPressed: () async {
                                    var picked =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                                    );
                                    if (picked != null) {
                                      print(picked.files.first.name);
                                      setState(() {
                                        _reciboPago = picked.files.first.bytes;
                                        _isReciboPagoEntered = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Subir",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            _isCompleted
                ? SizedBox(height: 10)
                : Container(
                    height: 50,
                    width: 235,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: kPrimaryColor,
                      child: MaterialButton(
                        onPressed: () {
                          if (_isConsentimientoEntered &&
                              _isConsentimientoTPEntered &&
                              _isFotoDocumentoEntered &&
                              _isReciboPagoEntered) {
                            ProviderDocumentosPaciente.documentarPacienteFoto(
                                pacienteActual, _fotoDocumento);
                            ProviderDocumentosPaciente
                                .documentarPacienteReciboPago(
                                    pacienteActual, _reciboPago);
                            ProviderDocumentosPaciente
                                .documentarPacienteConsentimientoP(
                                    pacienteActual, _consentimientoPrincipal);
                            ProviderDocumentosPaciente
                                .documentarPacienteConsentimientoTP(
                                    pacienteActual, _consentimientoTP);
                            _isCompleted = true;
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              "Completar Registro",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ));
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
