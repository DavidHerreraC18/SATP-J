import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';

class PreRegisterHomePage extends StatefulWidget {
  
  static const route = '/pre-registro';

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
                          padding: EdgeInsets.only(left:40.0),
                          alignment: Alignment.centerLeft,
                          color: kPrimaryColor,
                          child: Text('Formulario de Registro', 
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Dubai',
                              )
                            ,),
                        ),
                        Container( 
                          padding: EdgeInsets.all(40.0),
                          width: 850.0, 
                          child: RegisterForm()
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

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

final pacienteIndividual = new Paciente();
final integrante1 = new Paciente();
final integrante2 = new Paciente();

final grupo = new Grupo();

class RegisterFormState extends State<RegisterForm> {
  
  GlobalKey<FormState> _formKey;
  
  bool grupal = false;
  bool individual = false;
  
 
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    pacienteIndividual.edad = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: temaFormularios(),
      child: Form(
          key: _formKey,
          child:
         Column(
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
              Row(
              children: [
                  Checkbox(
                    value: individual,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        individual = newValue;
                        grupal = false;
                        });
                    }),
                Text(
                  'Individual',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
          ),       
          Row(
              children: [
                  Checkbox(
                    value: grupal,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        grupal = newValue;
                        individual = false;
                        });
                    }),
                Text(
                  'Para parejas',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
          ),
          SizedBox(
            height: 10.0,
          ),
          FormPatientInformation(
              paciente: pacienteIndividual,
              fechaNacimiento: true,
              prefix: 'su',
              label: '',
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
                    route: pacienteIndividual.edad >= 18 && individual ? PreRegisterPage3.route : 
                           pacienteIndividual.edad < 18 && individual  ? PreRegisterPage2.route : 
                           grupal ? PreRegisterPage1.route : 
                           null,
                    arguments: pacienteIndividual
                  ), 
                ),
              ],
          ),
          ]
          )),
    );
  }
}
