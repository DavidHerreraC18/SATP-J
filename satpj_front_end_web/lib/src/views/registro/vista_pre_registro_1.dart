
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';
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
                          child: RegisterFormPersonalInformation(paciente: new Paciente(),)
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
  
  Paciente paciente = new Paciente();

  RegisterFormPersonalInformation({this.paciente});
  
  @override
  RegisterFormPersonalInformationState createState() {
    return RegisterFormPersonalInformationState();
  }
}

class RegisterFormPersonalInformationState extends State<RegisterFormPersonalInformation> {
  
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = new GlobalKey<FormState>();
    widget.paciente.edad = 0;  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: temaFormularios(),
      child: Form(
          key: formKey,
          child:
         Column(
           crossAxisAlignment: CrossAxisAlignment.start, 
           children: [
            FormPatientInformation(
                paciente: widget.paciente,
                fechaNacimiento: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40.0,
                  child: ButtonForms(
                    formKey: formKey,
                    label: 'Siguiente',
                    color: kPrimaryColor,
                    route: widget.paciente.edad >= 18 ? PreRegisterPage3.route : PreRegisterPage2.route,
                    arguments: widget.paciente
                  ), 
                ),
              ],
          ),
          ])),
    );
  }
}
