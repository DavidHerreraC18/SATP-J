
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';

class PreRegisterPage1 extends StatefulWidget {
  static const route = '/pre-registro-1';

  @override
  _PreRegisterPage1State createState() => _PreRegisterPage1State();
}

class _PreRegisterPage1State extends State<PreRegisterPage1> {
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
                      right: 80.0, left: 80.0, top: 20.0, bottom: 20.0),
                  elevation: 25.0,
                  child: Column(
                      children: [
                        Container( 
                          padding: EdgeInsets.all(40.0),
                          width: 850.0, 
                          child: RegisterFormPersonalInformation(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}

class RegisterFormPersonalInformation extends StatefulWidget {
  
  RegisterFormPersonalInformation();
  
  @override
  RegisterFormPersonalInformationState createState() {
    return RegisterFormPersonalInformationState();
  }
}

class RegisterFormPersonalInformationState extends State<RegisterFormPersonalInformation> {
  
  GlobalKey<FormState> _formKey;
  Paciente paciente;
  Grupo grupo;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
     
     paciente = new Paciente();
     paciente.edad = 0;  
     paciente.estadoAprobado='PendienteAprobacion';

     grupo = new Grupo();
     grupo.integrantes = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null){
        grupo.integrantes.add(arguments['arguments'] as Paciente);
        grupo.integrantes.add(paciente);
        print(grupo.integrantes.length);
    }
    
    return Theme(
      data: temaFormularios(),
      child: Form(
          key: _formKey,
          child:
         Column(
           crossAxisAlignment: CrossAxisAlignment.start, 
           children: [
            FormPatientInformation(
                paciente: paciente,
                fechaNacimiento: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 126.0,
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Atras',
                    color: Colors.grey[600],
                    route: PreRegisterHomePage.route,
                  ),
                ),
                Container(
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Siguiente',
                    color: kPrimaryColor,
                    route: PreRegisterPage3.route,
                    arguments: grupo
                  ), 
                ),
              ],
          ),
          ])),
    );
  }
}
