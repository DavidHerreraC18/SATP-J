import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente_preaprobado.dart';
import 'package:satpj_front_end_web/src/utils/widgets/LoadingWidgets/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente_extra.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/documentacion/vista_registro_documentos.dart';

class RegisterHomePage extends StatefulWidget {
  static const route = '/registro';

  RegisterHomePage({Key key}) : super(key: key);

  @override
  _RegisterHomePageState createState() => _RegisterHomePageState();
}

class _RegisterHomePageState extends State<RegisterHomePage> {
  Paciente pacienteActual;
  @override
  initState() {
    //buscarPaciente();
    super.initState();
  }

  Future<String> buscarPaciente() async {
    String uid = ProviderAuntenticacion.uid;
    pacienteActual = await ProviderAdministracionPacientes.buscarPaciente(uid);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: buscarPaciente(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                backgroundColor: kAccentColor,
                appBar: toolbarPacientePreaprobado(context),
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
                                  child: RegisterForm(
                                    pacienteActual: this.pacienteActual,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}

class RegisterForm extends StatefulWidget {
  final Paciente pacienteActual;

  RegisterForm({this.pacienteActual});

  @override
  RegisterFormState createState() {
    return RegisterFormState(this.pacienteActual);
  }
}

class RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey;

  Paciente pacienteActual;

  RegisterFormState(Paciente paciente) {
    this.pacienteActual = paciente;
  }

  String definirRuta() {
    return VistaRegistroDocumentos.route;
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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
              'Complete la siguiente información adicional:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            FormPatientExtraInformation(
              pacienteActual: pacienteActual,
            ),
          ],
        ),
      ),
    );
  }
}
