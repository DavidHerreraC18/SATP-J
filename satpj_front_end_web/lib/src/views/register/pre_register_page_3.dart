import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/modelo/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_2.dart';

import '../../constants.dart';

class PreRegisterPage3 extends StatefulWidget {
  
  final Paciente paciente;

  static const route = '/pre-registro-3';

  PreRegisterPage3({this.paciente});

  @override
  _PreRegisterPage3State createState() => _PreRegisterPage3State();
}

class _PreRegisterPage3State extends State<PreRegisterPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor,
        appBar: toolbarInicio(context),
        body: ListView(
          children: [
            Column(
              children: [
                Theme(
                data: temaFormularios(),
                child: Card(
                  margin: EdgeInsets.only(
                      right: 100.0, left: 100.0, top: 20.0, bottom: 20.0),
                  elevation: 25.0,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Container(width: 700, child: RegisterForm()),
                  ),
                 )
                )
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
  bool decisionPropia = false;
  bool remitido = false;
  bool cualRemision = false;
  bool atendidoNo = false;
  bool atendido = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Solicita la atención psicológica por:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Row(
              children: [
                Checkbox(
                    value: decisionPropia,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        decisionPropia = newValue;
                        remitido = false;
                      });
                    }),
                Text(
                  'Decisión propia',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Row(
              children: [
                Checkbox(
                    value: remitido,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        remitido = newValue;
                        decisionPropia = false;
                      });
                    }),
                Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
                Text(
                  'Remitido',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: remitido
                ? [
                    Text(
                      'Fue remitido por:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                        height: 50.0,
                        child: Dropdown(
                            values: kInstituciones,
                           )),
                  ]
                : [],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cualRemision
                ? [
                    Text(
                      '¿Cúal?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextField(
                      hintText: 'Institución de remisión',
                      type: TextInputType.datetime,
                    ),
                  ]
                : [],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Motivo de la consulta',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: RoundedTextField(
              hintText: 'Motivo de la consulta',
              type: TextInputType.text,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Anteriormente ha recibido atención por psicológia o psiquiatría:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Row(
              children: [
                Checkbox(
                    value: atendido,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        atendido = newValue;
                        atendidoNo = false;
                      });
                    }),
                Text(
                  'Si',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Row(
              children: [
                Checkbox(
                    value: atendidoNo,
                    activeColor: kPrimaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        atendidoNo = newValue;
                        atendido = false;
                      });
                    }),
                Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
                Text(
                  'No',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: atendido
                ? [
                    Text(
                      '¿Donde?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextField(
                      hintText: 'Institución donde recibio la atención',
                      type: TextInputType.text,
                    ),
                  ]
                : [],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 110.0,
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Atras',
                    color: Colors.grey[600],
                    route: PreRegisterPage2.route,
                  ),
              ),
              Container(
                height: 40.0,
                child: ButtonForms(formKey: _formKey, color: kPrimaryColor, label:'Enviar'),
              ),
            ],
          ),
        ]));
  }
}