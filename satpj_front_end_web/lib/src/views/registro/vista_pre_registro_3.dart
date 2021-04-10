import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';

import '../../constants.dart';

class PreRegisterPage3 extends StatefulWidget {
  static const route = '/pre-registro-3';

  PreRegisterPage3();

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
                          right: 80.0, left: 80.0, top: 20.0, bottom: 20.0),
                      elevation: 25.0,
                      child: Container(
                          padding: EdgeInsets.all(40.0),
                          width: 850.0,
                          child: RegisterForm()),
                    ))
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
  Paciente paciente;
  Grupo grupo;
  Formulario formularioPreRegistro;

  TextEditingController textControllerInstitucionRemision;

  TextEditingController textControllerNombreInstitucion;
  FocusNode textFocusNodeNombreInstitucion;
  bool _isEditingNombreInstitucion = false;

  TextEditingController textControllerMotivo;
  FocusNode textFocusNodeMotivo;
  bool _isEditingMotivo = false;

  TextEditingController textControllerInstitucionAtencion;
  FocusNode textFocusNodeInstitucionAtencion;
  bool _isEditingInstitucionAtencion = false;

  bool decisionPropia = false;
  bool cualRemision = false;
  bool atendidoNo = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    paciente = new Paciente();
    paciente.edad = 0;
    paciente.remitido = false;
    paciente.estadoAprobado = 'PendienteAprobacion';

    grupo = new Grupo();
    grupo.integrantes = [];

    formularioPreRegistro = new Formulario();
    formularioPreRegistro.fueAtendido = false;

    textControllerInstitucionRemision = TextEditingController(text: null);
    textControllerMotivo = TextEditingController(text: null);
    textControllerInstitucionAtencion = TextEditingController(text: null);
    textControllerNombreInstitucion = TextEditingController(text: null);

    textFocusNodeMotivo = FocusNode();
    textFocusNodeInstitucionAtencion = FocusNode();
    textFocusNodeNombreInstitucion = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      if (arguments['arguments'] is Paciente) {
        paciente = arguments['arguments'] as Paciente;
      } else {
        grupo = arguments['arguments'] as Grupo;
        paciente = grupo.integrantes.first;
        print(
            'PANTALLA 3 ${grupo.integrantes.length} GRUPO ${grupo.integrantes.last.nombre}');
      }
    }

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
          Row(
            children: [
              Checkbox(
                  value: decisionPropia,
                  activeColor: kPrimaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      decisionPropia = value;
                      paciente.remitido = false;
                      cualRemision = false;
                    });
                  }),
              Text(
                'Decisión propia',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Checkbox(
                  value: paciente.remitido,
                  activeColor: kPrimaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      paciente.remitido = value;
                      decisionPropia = false;
                      cualRemision = false;
                    });
                  }),
              Text(
                'Remitido',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paciente.remitido
                ? [
                    SizedBox(height: 8.0),
                    Text(
                      'Fue remitido por:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField<String>(
                      iconSize: 24,
                      elevation: 16,
                      hint: Text('Instituciones'),
                      decoration: inputDecoration(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                          fontFamily: 'Dubai'),
                      items: kInstituciones
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.5,
                                      fontFamily: 'Dubai'),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          textControllerInstitucionRemision.text = value;
                          formularioPreRegistro.remitente = value;
                          if (textControllerInstitucionRemision.text ==
                              'Otra') {
                            cualRemision = true;
                            formularioPreRegistro.remitente = '';
                          }
                        });
                      },
                      validator: (value) => value == null
                          ? ValidadoresInput.validateEmpty(
                              textControllerInstitucionRemision.text,
                              'Seleccione una institución',
                              '')
                          : null,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ]
                : [],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cualRemision
                ? [
                    Text(
                      'Indique el nombre de la institución de donde fue remitido:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextFieldValidators(
                        textFocusNode: textFocusNodeNombreInstitucion,
                        textController: textControllerNombreInstitucion,
                        textInputType: TextInputType.text,
                        isEditing: _isEditingNombreInstitucion,
                        hintText: 'Institución de remisión',
                        validate: () {
                          formularioPreRegistro.remitente =
                              textControllerNombreInstitucion.text;
                          if (cualRemision) {
                            return ValidadoresInput.validateEmpty(
                                textControllerNombreInstitucion.text,
                                'Debe ingresar el nombre de la institución de donde fue remitido',
                                '');
                          }
                          return null;
                        }),
                  ]
                : [],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Motivo de la consulta:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeMotivo,
              textController: textControllerMotivo,
              textInputType: TextInputType.text,
              isEditing: _isEditingMotivo,
              hintText: 'Motivo de la consulta',
              validate: () {
                formularioPreRegistro.motivoConsulta =
                    textControllerMotivo.text;
                return ValidadoresInput.validateEmpty(textControllerMotivo.text,
                    'Debe ingresar el Motivo de la consulta', '');
              }),
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
          Row(
            children: [
              Checkbox(
                  value: formularioPreRegistro.fueAtendido,
                  activeColor: kPrimaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      formularioPreRegistro.fueAtendido = value;
                      atendidoNo = false;
                    });
                  }),
              Text(
                'Sí',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formularioPreRegistro.fueAtendido
                ? [
                    Text(
                      '¿Dónde recibió la atención médica?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextFieldValidators(
                        textFocusNode: textFocusNodeInstitucionAtencion,
                        textController: textControllerInstitucionAtencion,
                        textInputType: TextInputType.text,
                        isEditing: _isEditingInstitucionAtencion,
                        hintText:
                            'Institución donde recibio atención psicológica',
                        validate: () {
                          formularioPreRegistro.lugarAtencion =
                              textControllerInstitucionAtencion.text;
                          if (formularioPreRegistro.fueAtendido) {
                            return ValidadoresInput.validateEmpty(
                                textControllerInstitucionAtencion.text,
                                'Ingrese el nombre de la institución donde recibio atención psicológica',
                                '');
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                  ]
                : [],
          ),
          Row(
            children: [
              Checkbox(
                  value: atendidoNo,
                  activeColor: kPrimaryColor,
                  onChanged: (bool newValue) {
                    setState(() {
                      atendidoNo = newValue;
                      formularioPreRegistro.fueAtendido = false;
                    });
                  }),
              Text(
                'No',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
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
                  route: grupo.integrantes.length > 0 ? PreRegisterPage1.route : 
                         PreRegisterPage2.route,
                ),
              ),
              Container(
                height: 40.0,
                child: ButtonForms(
                    formKey: _formKey, 
                    color: kPrimaryColor, 
                    label: 'Enviar'),
              ),
            ],
          ),
        ]));
  }
}
