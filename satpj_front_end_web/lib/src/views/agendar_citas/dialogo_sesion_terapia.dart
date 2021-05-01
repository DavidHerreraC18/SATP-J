import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Calendarios/CustomAppointment.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/gestionar_agendamiento.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DialogoAgendarSesionTerapia extends StatefulWidget {
  DialogoAgendarSesionTerapia(
      {Paciente paciente,
      SesionTerapia sesion,
      Practicante practicante,
      this.horario,
      this.appointment,
      this.selectedAppointment,
      this.sesionesTerapia,
      this.events,
      String labelConfirmBtn = 'Crear'}) {
    pacienteSesion = paciente;
    practicanteAsignado = practicante;
    sesionTerapia = sesion;
    labelConfirmB = labelConfirmBtn;
  }
  final List<SesionTerapia> sesionesTerapia;

  final List<CustomAppointment> appointment;

  final CustomAppointment selectedAppointment;

  final CalendarDataSource events;

  final Horario horario;

  @override
  _DialogoAgendarSesionTerapiaState createState() =>
      _DialogoAgendarSesionTerapiaState();
}

Paciente pacienteSesion = new Paciente();
Practicante practicanteAsignado = new Practicante();
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
          text: widget.selectedAppointment.startTime.toString());
      virtual = sesionTerapia.virtual;
      presencial = !sesionTerapia.virtual;

      if (virtual)
        textControllerConsultorioVirtual =
            TextEditingController(text: sesionTerapia.consultorio);
      else
        textControllerConsultorio.text = sesionTerapia.consultorio;
    } else {
      textControllerFechaSesion = TextEditingController(
          text: widget.selectedAppointment.startTime.toString());
      textControllerConsultorio = TextEditingController(text: null);
    }

    textControllerPaciente = TextEditingController(
        text: pacienteSesion.nombre + ' ' + pacienteSesion.apellido);
    textControllerPracticante = TextEditingController(
        text: practicanteAsignado.nombre + ' ' + practicanteAsignado.apellido);
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
                              enabled: false,
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
                            RoundedTextFieldValidators(
                              textFocusNode: textFocusNodeConsultorio,
                              textController: textControllerConsultorio,
                              textInputType: TextInputType.text,
                              isEditing: false,
                              enabled: true,
                            ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    (sesionTerapia != null)
                        ? FotterDialog(
                            labelCancelBtn: 'Regresar',
                            labelConfirmBtn: "Cancelar Cita",
                            colorConfirmBtn: kPrimaryColor,
                            functionConfirmBtn: () {
                              if (widget.events.appointments.isNotEmpty &&
                                  widget.events.appointments
                                      .contains(widget.selectedAppointment)) {
                                widget.events.appointments.removeAt(widget
                                    .events.appointments
                                    .indexOf(widget.selectedAppointment));
                                widget.events.notifyListeners(
                                    CalendarDataSourceAction.remove,
                                    <Appointment>[]
                                      ..add(widget.selectedAppointment));
                              }
                              DateTime newStartTime = new DateTime(
                                  sesionTerapia.fecha.year,
                                  sesionTerapia.fecha.month,
                                  sesionTerapia.fecha.day,
                                  sesionTerapia.hora.hour,
                                  sesionTerapia.hora.second);
                              DateTime newEndTime =
                                  newStartTime.add(new Duration(hours: 1));
                              widget.appointment.add(CustomAppointment(
                                startTime: newStartTime,
                                endTime: newEndTime,
                                color: Color(0xFF7EEFC6),
                                isAllDay: false,
                                subject: "Disponible",
                              ));
                              widget.events.appointments
                                  .add(widget.appointment[0]);
                              widget.events.notifyListeners(
                                  CalendarDataSourceAction.add,
                                  widget.appointment);
                            },
                            width: 120.0,
                          )
                        : FotterDialog(
                            labelCancelBtn: 'Cancelar',
                            labelConfirmBtn: "Crear",
                            colorConfirmBtn: kPrimaryColor,
                            functionConfirmBtn: () {
                              print("AAAAAAAA");
                              if (widget.events.appointments.isNotEmpty &&
                                  widget.events.appointments
                                      .contains(widget.selectedAppointment)) {
                                widget.events.appointments.removeAt(widget
                                    .events.appointments
                                    .indexOf(widget.selectedAppointment));
                                widget.events.notifyListeners(
                                    CalendarDataSourceAction.remove,
                                    <Appointment>[]
                                      ..add(widget.selectedAppointment));
                              }
                              widget.sesionesTerapia.removeAt(widget
                                  .sesionesTerapia
                                  .indexOf(sesionTerapia));

                              DateTime fecha = new DateTime(
                                  widget.selectedAppointment.startTime.hour,
                                  widget.selectedAppointment.startTime.month,
                                  widget.selectedAppointment.startTime.day);
                              DateTime hora = new DateTime(
                                  widget.selectedAppointment.startTime.hour,
                                  widget.selectedAppointment.startTime.month,
                                  widget.selectedAppointment.startTime.day,
                                  widget.selectedAppointment.startTime.hour);
                              SesionTerapia nueva = new SesionTerapia(
                                fecha: fecha,
                                hora: hora,
                                virtual: virtual,
                                consultorio: (virtual)
                                    ? ''
                                    : textControllerConsultorio.text,
                              );
                              widget.sesionesTerapia.add(nueva);
                              widget.appointment.add(CustomAppointment(
                                id: widget.sesionesTerapia.length = 1,
                                startTime: widget.selectedAppointment.startTime,
                                endTime: widget.selectedAppointment.endTime,
                                color: Color(0xFFFF637D),
                                notes: '',
                                isAllDay: false,
                                subject: virtual
                                    ? "Sesión Virtual"
                                    : "Sesion Presencial - Consultorio:" +
                                        nueva.consultorio,
                              ));
                              widget.events.appointments
                                  .add(widget.appointment[0]);
                              widget.events.notifyListeners(
                                  CalendarDataSourceAction.add,
                                  widget.appointment);
                            },
                            width: 120.0,
                          ),
                  ]),
                ))));
  }
}
