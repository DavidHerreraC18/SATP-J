import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente_extra.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/documentacion/vista_registro_documentos.dart';

class PreRegisterHomePage extends StatefulWidget {
  static const route = '/registro';

  @override
  _PreRegisterHomePageState createState() => _PreRegisterHomePageState();
}

class _PreRegisterHomePageState extends State<PreRegisterHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor,
        appBar: toolbarInicio(context),
        body: ListView(
          children: [
            Column(
              children: [
                Card(
                  margin: EdgeInsets.only(
                      right: 50.0, left: 50.0, top: 20.0, bottom: 20.0),
                  elevation: 25.0,
                  child: Column(
                    children: [
                      Container(
                        height: 80.0,
                        width: 850.0,
                        padding: EdgeInsets.only(left: 40.0),
                        alignment: Alignment.centerLeft,
                        color: kPrimaryColor,
                        child: Text(
                          'Formulario de Registro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Dubai',
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(40.0),
                          width: 850.0,
                          child: RegisterForm()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey;

  bool grupal = false;
  bool individual = false;

  Paciente paciente;

  String definirRuta() {
    return VistaRegistroDocumentos.route;
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    paciente = new Paciente();
    paciente.edad = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: temaFormularios(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Solicita atención psicológica:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            FormPatientExtraInformation(
              paciente: paciente,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40.0,
                  child: ButtonForms(
                      formKey: _formKey,
                      label: 'Siguiente',
                      color: kPrimaryColor,
                      functionRouting: (int edad) => definirRuta(),
                      arguments: paciente),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
