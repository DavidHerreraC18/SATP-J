import 'dart:async';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_acudiente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_perfil_acudiente.dart';

class VistaEditarAcudiente extends StatefulWidget {
  static const route = '/perfil-editar-acudiente';
  VistaEditarAcudiente({Key key}) : super(key: key);

  @override
  _VistaEditarAcudienteState createState() => _VistaEditarAcudienteState();
}

class _VistaEditarAcudienteState extends State<VistaEditarAcudiente> {
  Usuario acudienteActual;
  @override
  initState() {
    super.initState();
  }

  Future<String> obtenerAcudiente() async {
    String uid = ProviderAuntenticacion.uid;
    acudienteActual = await ProviderAdministracionUsuarios.buscarUsuario(uid);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerAcudiente(), // function where you call your api
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
                appBar: toolbarAcudiente(context),
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
                                              child: NombreAcudiente(
                                                  acudienteActual:
                                                      this.acudienteActual)),
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
                                              DatosAcudiente(
                                                acudienteActual:
                                                    this.acudienteActual,
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

class DatosAcudiente extends StatefulWidget {
  final Usuario acudienteActual;
  DatosAcudiente({this.acudienteActual});
  @override
  DatosAcudienteState createState() {
    return DatosAcudienteState(acudienteActual);
  }
}

class DatosAcudienteState extends State<DatosAcudiente> {
  Usuario acudienteActual;

  TextEditingController textControllerTel;
  FocusNode textFocusTel;
  bool _isEditingTel = false;

  TextEditingController textControllerEmail;
  FocusNode textFocusEmail;
  bool _isEditingEmail = false;

  TextEditingController textControllerDir;
  FocusNode textFocusDir;
  bool _isEditingDir = false;

  DatosAcudienteState(Usuario usuario) {
    this.acudienteActual = usuario;
  }
  @override
  void initState() {
    super.initState();
    textControllerDir = TextEditingController(text: null);
    textFocusDir = FocusNode();
    textControllerEmail = TextEditingController(text: null);
    textFocusEmail = FocusNode();
    textControllerTel = TextEditingController(text: null);
    textFocusTel = FocusNode();
    textControllerDir.text = acudienteActual.direccion;
    textControllerEmail.text = acudienteActual.email;
    textControllerTel.text = acudienteActual.telefono;
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
                              acudienteActual.tipoDocumento + ": ",
                              acudienteActual.documento,
                              Icon(FontAwesome.address_card,
                                  size: 20.0, color: kPrimaryColor))),
                      Flexible(
                          child: _containerDatosEdit(
                              Icon(Icons.email,
                                  size: 20.0, color: kPrimaryColor),
                              textControllerEmail,
                              textFocusEmail,
                              _isEditingEmail,
                              true)),
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
                          child: _containerDatosEdit(
                              Icon(Icons.phone,
                                  size: 20.0, color: kPrimaryColor),
                              textControllerTel,
                              textFocusTel,
                              _isEditingTel,
                              false)),
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
                          child: _containerDatosEdit(
                              Icon(Icons.house,
                                  size: 20.0, color: kPrimaryColor),
                              textControllerDir,
                              textFocusDir,
                              _isEditingDir,
                              false)),
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
                      icon: Icon(Icons.save),
                      color: kPrimaryColor,
                      onPressed: () async {
                        if (textControllerDir.text.isNotEmpty &&
                            textControllerTel.text.isNotEmpty &&
                            textControllerEmail.text.isNotEmpty) {
                          String respuesta = ValidadoresInput.validateEmail(
                              textControllerEmail.text);
                          if (respuesta == null) {
                            Usuario editar =
                                await ProviderAdministracionUsuarios
                                    .buscarUsuario(acudienteActual.id);
                            editar.direccion = textControllerDir.text;
                            editar.telefono = textControllerTel.text;
                            editar.email = textControllerEmail.text;
                            await ProviderAuntenticacion.updateEmail(
                                editar.email);
                            await ProviderAdministracionUsuarios.editarUsuario(
                                editar);
                          } else if (respuesta ==
                                  'El correo electrónico ya se encuentra registrado' &&
                              textControllerEmail.text ==
                                  acudienteActual.email) {
                            Usuario editar =
                                await ProviderAdministracionUsuarios
                                    .buscarUsuario(acudienteActual.id);
                            editar.direccion = textControllerDir.text;
                            editar.telefono = textControllerTel.text;
                            await ProviderAdministracionUsuarios.editarUsuario(
                                editar);
                          }
                          Navigator.pushNamed(
                              context, VistaPerfilAcudiente.route);
                        }
                      }),
                ),
              ],
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
              title: Text(texto + datoUsuario,
                  style: TextStyle(
                      height: 1.1, fontSize: 16, color: Colors.black)),
              leading: icono));
  Container _containerDatosEdit(
          Icon icono,
          TextEditingController textEditingController,
          FocusNode focusNode,
          bool isEditing,
          bool email) =>
      Container(
          alignment: Alignment.center,
          height: 20.0,
          constraints: BoxConstraints(minWidth: 125, maxWidth: 350),
          width: 350,
          child: ListTile(
              title: RoundedTextFieldValidators(
                  textFocusNode: focusNode,
                  textController: textEditingController,
                  textInputType: TextInputType.text,
                  isEditing: isEditing,
                  fontSize: 16.0,
                  hintText: '',
                  validate: () {
                    if (!email) {
                      return ValidadoresInput.validateEmpty(
                          textEditingController.text,
                          'Debe ingresar  el valor correspondiente a Otro',
                          '');
                    } else {
                      return ValidadoresInput.validateEmail(
                          textEditingController.text);
                    }
                  }),
              leading: icono));
}

class NombreAcudiente extends StatefulWidget {
  final Usuario acudienteActual;
  NombreAcudiente({this.acudienteActual});

  @override
  NombreAcudienteState createState() {
    return NombreAcudienteState(this.acudienteActual);
  }
}

class NombreAcudienteState extends State<NombreAcudiente> {
  Usuario acudienteActual;

  NombreAcudienteState(Usuario auxiliar) {
    this.acudienteActual = auxiliar;
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
                    Text(
                        acudienteActual.nombre + " " + acudienteActual.apellido,
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("Acudiente",
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
