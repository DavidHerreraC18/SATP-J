import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

import '../../constants.dart';

class DialogoAgendarSesionTerapia extends StatefulWidget {

  DialogoAgendarSesionTerapia({
         Paciente paciente, 
         SesionTerapia sesion,
         String labelConfirmBtn = 'Crear'
         }) {
         pacienteSesion = paciente;
         sesionTerapia = sesion;
         labelConfirmB = labelConfirmBtn;
  }

  @override
  _DialogoAgendarSesionTerapiaState createState() =>
      _DialogoAgendarSesionTerapiaState();
}

Paciente pacienteSesion = new Paciente();
SesionTerapia sesionTerapia;
String labelConfirmB;

class _DialogoAgendarSesionTerapiaState
    extends State<DialogoAgendarSesionTerapia> {
  bool virtual = false;
  bool presencial = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TimeOfDay selectedTime;

  TextEditingController textControllerPaciente;
  FocusNode textFocusNodePaciente;

  TextEditingController textControllerFechaSesion;
  FocusNode textFocusNodeFechaSesion;

  TextEditingController textControllerPracticante;
  FocusNode textFocusNodePracticante;

  TextEditingController textControllerSupervisor;
  FocusNode textFocusNodeSupervisor;

  TextEditingController textControllerHoraSesion;
  FocusNode textFocusNodeHoraSesion;

  TextEditingController textControllerConsultorio;
  FocusNode textFocusNodeConsultorio;

  TextEditingController textControllerConsultorioVirtual;
  FocusNode textFocusNodeConsultorioVirtual;

  @override
  void initState() {
    virtual = false;
    presencial = false;
    selectedTime = TimeOfDay(hour: 00, minute: 0);

    textControllerConsultorio = TextEditingController();

    if (sesionTerapia != null) {
      textControllerFechaSesion = TextEditingController(
          text: sesionTerapia.fecha.toString() +
              ' ' +
              sesionTerapia.hora.toString());
      virtual = sesionTerapia.virtual;
      presencial = !sesionTerapia.virtual;
      
      if(virtual) 
        textControllerConsultorioVirtual =
        TextEditingController(text: sesionTerapia.consultorio); 
      
      else 
        textControllerConsultorio.text = sesionTerapia.consultorio;
      
    } else{
      textControllerFechaSesion = TextEditingController(text: null);
      textControllerConsultorio =
        TextEditingController(text: null);
    }
 
    textControllerPaciente = TextEditingController(
        text: pacienteSesion.nombre + ' ' + pacienteSesion.apellido);
    textControllerPracticante = TextEditingController(text: null);
    textControllerSupervisor = TextEditingController(
        text: pacienteSesion.supervisor.nombre +
            ' ' +
            pacienteSesion.supervisor.apellido);

    textFocusNodeFechaSesion = FocusNode();
    textFocusNodeHoraSesion = FocusNode();
    textFocusNodePaciente = FocusNode();
    textFocusNodePracticante = FocusNode();
    textFocusNodeSupervisor = FocusNode();
    textFocusNodeConsultorio = FocusNode();
    textFocusNodeConsultorioVirtual = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaFormularios(),
        child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Container(
                width: 650.0,
                child: Form(
                  key: _formKey,
                  child: ListView(children: [
                    HeaderDialog(
                      label: 'Crear Sesión de Terapia',
                      height: 55.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: 570.0,
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              timeLabelText: 'Hora',
                              dateLabelText: 'Fecha de la sesión de terapia',
                              dateMask: 'dd-MM-yyyy',
                              controller: textControllerFechaSesion,
                              focusNode: textFocusNodeFechaSesion,
                              //decoration: datePickerDecoration,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime.now(),
                              icon: Icon(Icons.event, color: kPrimaryColor),
                              onChanged: (val) {},
                              validator: (val) {
                                return ValidadoresInput.validateEmpty(
                                    textControllerFechaSesion.text,
                                    'Debe ingresar la fecha de la sesión de terapia',
                                    '');
                              },
                              onSaved: (val) => print(val),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Paciente:',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldValidators(
                            textFocusNode: textFocusNodePaciente,
                            textController: textControllerPaciente,
                            textInputType: TextInputType.text,
                            isEditing: false,
                            enabled: false,
                            hintText: '',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Practicante:',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldValidators(
                            textFocusNode: textFocusNodePracticante,
                            textController: textControllerPracticante,
                            textInputType: TextInputType.text,
                            isEditing: false,
                            enabled: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Supervisor:',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldValidators(
                            textFocusNode: textFocusNodeSupervisor,
                            textController: textControllerSupervisor,
                            textInputType: TextInputType.text,
                            isEditing: false,
                            enabled: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Tipo de la sesión de terapia:',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: virtual,
                                  activeColor: kPrimaryColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      virtual = value;
                                      presencial = false;
                                      //sesionTerapia.virtual = virtual;
                                    });
                                  }),
                              Text(
                                'Virtual',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                          Row(children: [
                            Checkbox(
                                value: presencial,
                                activeColor: kPrimaryColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    presencial = value;
                                    virtual = false;
                                    //sesionTerapia.virtual = virtual;
                                  });
                                }),
                            Text(
                              'Presencial',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ]),
                          SizedBox(
                            height: 8.0,
                          ),
                          if (virtual || presencial)
                            Text(
                              'Consultorio:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          SizedBox(
                            height: 8.0,
                          ),
                          if (virtual)
                            RoundedTextFieldValidators(
                              textFocusNode: textFocusNodeConsultorioVirtual,
                              textController: textControllerConsultorioVirtual,
                              textInputType: TextInputType.text,
                              isEditing: false,
                              enabled: false,
                            ),
                          if (presencial)
                            Dropdown(
                                textController: textControllerConsultorio,
                                focusNode: textFocusNodeConsultorio,
                                hintText: 'Consultorio',
                                values: kTtipoDocumento,
                                validate: () {
                                  if(textControllerConsultorio.text.isNotEmpty)
                                  sesionTerapia.consultorio =
                                      textControllerConsultorio.text;
                                  return ValidadoresInput.validateEmpty(
                                      textControllerConsultorio.text,
                                      'Seleccione el consultorio',
                                      '');
                                }),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    FotterDialog(
                      labelCancelBtn: 'Cancelar',
                      labelConfirmBtn: labelConfirmB,
                      colorConfirmBtn: kPrimaryColor,
                      width: 120.0,
                    ),
                  ]),
                ))));
  }
}
