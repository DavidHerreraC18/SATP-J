import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/consultorio/consultorio.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/llave_sesion_usuario.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_sesiones_terapia.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/calendarios/CustomAppointment.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DialogoAgendarSesionTerapia extends StatefulWidget {
  DialogoAgendarSesionTerapia(
      {@required this.pacienteSesion,
      @required this.sesionTerapia,
      @required this.practicanteAsignado,
      @required this.consultorios,
      this.horario,
      this.selectedAppointment,
      this.sesionesTerapia,
      this.events,
      this.funcionActualizar,
      String labelConfirmBtn = 'Crear'});
  final List<SesionTerapia> sesionesTerapia;

  final List<Consultorio> consultorios;

  final CustomAppointment selectedAppointment;

  final CalendarDataSource events;

  final Function funcionActualizar;

  final Horario horario;

  final Paciente pacienteSesion;

  final Practicante practicanteAsignado;

  final SesionTerapia sesionTerapia;

  @override
  _DialogoAgendarSesionTerapiaState createState() =>
      _DialogoAgendarSesionTerapiaState();
}

class _DialogoAgendarSesionTerapiaState
    extends State<DialogoAgendarSesionTerapia> {
  bool virtual = false;
  bool presencial = false;

  List<String> consultoriosNombres;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _consultorioNombreActual;
  Consultorio _consultorioActual;

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
    consultoriosNombres = [];
    if (widget.consultorios.isNotEmpty) {
      for (int i = 0; i < widget.consultorios.length; i++) {
        consultoriosNombres.add(widget.consultorios[i].consultorio + "");
      }
      _consultorioNombreActual = consultoriosNombres[0];
      _consultorioActual = widget.consultorios[0];
      _dropDownMenuItems = getDropDownMenuItems();
    }

    textControllerConsultorio = TextEditingController();

    if (widget.sesionTerapia != null) {
      textControllerFechaSesion = TextEditingController(
          text: widget.selectedAppointment.startTime.toString());
      virtual = widget.sesionTerapia.virtual;
      presencial = !widget.sesionTerapia.virtual;

      if (virtual)
        textControllerConsultorioVirtual = TextEditingController(
            text: widget.sesionTerapia.consultorio.consultorio);
      else
        textControllerConsultorio.text =
            widget.sesionTerapia.consultorio.consultorio;
    } else {
      textControllerFechaSesion = TextEditingController(
          text: widget.selectedAppointment.startTime.toString());
      textControllerConsultorio = TextEditingController(text: null);
    }

    textControllerPaciente = TextEditingController(
        text: widget.pacienteSesion.nombre +
            ' ' +
            widget.pacienteSesion.apellido);
    textControllerPracticante = TextEditingController(
        text: widget.practicanteAsignado.nombre +
            ' ' +
            widget.practicanteAsignado.apellido);
    if (widget.pacienteSesion.supervisor != null) {
      textControllerSupervisor = TextEditingController(
          text: widget.pacienteSesion.supervisor.nombre +
              ' ' +
              widget.pacienteSesion.supervisor.apellido);
    } else {
      textControllerSupervisor = TextEditingController(text: 'No asignado');
    }

    textFocusNodeFechaSesion = FocusNode();
    textFocusNodeHoraSesion = FocusNode();
    textFocusNodePaciente = FocusNode();
    textFocusNodePracticante = FocusNode();
    textFocusNodeSupervisor = FocusNode();
    textFocusNodeConsultorio = FocusNode();
    textFocusNodeConsultorioVirtual = FocusNode();

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String consult in consultoriosNombres) {
      items.add(new DropdownMenuItem(value: consult, child: new Text(consult)));
    }
    return items;
  }

  void changedDropDownItem(String selectedSup) {
    setState(() {
      _consultorioNombreActual = selectedSup;
      for (int i = 0; i < consultoriosNombres.length; i++) {
        if (consultoriosNombres[i] == _consultorioNombreActual) {
          _consultorioActual = widget.consultorios[i];
          i = consultoriosNombres.length;
        }
      }
    });
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
                            DropdownButtonFormField(
                              decoration: inputDecoration(),
                              value: _consultorioNombreActual,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    (widget.sesionTerapia != null)
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
                              if (widget.sesionesTerapia.isNotEmpty &&
                                  widget.sesionesTerapia
                                      .contains(widget.sesionTerapia)) {
                                int indexActualizar = widget.sesionesTerapia
                                    .indexOf(widget.sesionTerapia);
                                widget.sesionesTerapia.removeAt(widget
                                    .sesionesTerapia
                                    .indexOf(widget.sesionTerapia));
                                ProviderSesionesTerapia.eliminarSesionTerapia(
                                    widget.sesionTerapia.id);
                                for (int i = 0;
                                    i < widget.events.appointments.length;
                                    i++) {
                                  CustomAppointment a =
                                      widget.events.appointments[i];
                                  if (a.id > indexActualizar) {
                                    a.id = a.id - 1;
                                    widget.events.appointments[i] = a;
                                  }
                                }
                              }
                              DateTime newStartTime = new DateTime(
                                  widget.sesionTerapia.fecha.year,
                                  widget.sesionTerapia.fecha.month,
                                  widget.sesionTerapia.fecha.day,
                                  widget.sesionTerapia.fecha.hour,
                                  widget.sesionTerapia.fecha.minute);
                              DateTime newEndTime =
                                  newStartTime.add(new Duration(hours: 1));
                              print(widget.events.appointments.length);
                              final List<Appointment> appointment =
                                  <Appointment>[];
                              CustomAppointment nuevoAppointment =
                                  new CustomAppointment(
                                id: -1,
                                startTime: newStartTime,
                                endTime: newEndTime,
                                color: Color(0xFF7EEFC6),
                                isAllDay: false,
                                subject: "Disponible",
                              );
                              print(widget.events.appointments.length);
                              appointment.add(nuevoAppointment);
                              widget.events.appointments.add(appointment[0]);
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration duration) {
                                widget.events.notifyListeners(
                                    CalendarDataSourceAction.add, appointment);
                              });
                              print(widget.events.appointments.length);
                              widget.funcionActualizar(
                                  widget.sesionesTerapia,
                                  widget.events.appointments,
                                  widget.events,
                                  widget.events.appointments);
                            },
                            width: 120.0,
                          )
                        : FotterDialog(
                            labelCancelBtn: 'Cancelar',
                            labelConfirmBtn: "Crear",
                            colorConfirmBtn: kPrimaryColor,
                            functionConfirmBtn: () async {
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
                              if (widget.sesionesTerapia.isNotEmpty &&
                                  widget.sesionesTerapia
                                      .contains(widget.sesionTerapia)) {
                                widget.sesionesTerapia.removeAt(widget
                                    .sesionesTerapia
                                    .indexOf(widget.sesionTerapia));
                              }

                              DateTime fecha = new DateTime(
                                  widget.selectedAppointment.startTime.year,
                                  widget.selectedAppointment.startTime.month,
                                  widget.selectedAppointment.startTime.day,
                                  widget.selectedAppointment.startTime.hour,
                                  widget.selectedAppointment.startTime.minute);
                              SesionTerapia nueva = new SesionTerapia(
                                fecha: fecha,
                                virtual: virtual,
                                consultorio: (virtual)
                                    ? _consultorioActual
                                    : textControllerConsultorio.text,
                              );
                              widget.sesionesTerapia.add(nueva);
                              SesionTerapia sesionTerapiaNueva =
                                  await ProviderSesionesTerapia
                                      .crearSesionTerapia(widget.sesionTerapia);
                              LlaveSesionUsuario nuevaLlave =
                                  new LlaveSesionUsuario(
                                      sesion_terapia_id: sesionTerapiaNueva.id,
                                      usuarioId: widget.pacienteSesion.id);
                              SesionUsuario nuevaSesionUsuario =
                                  new SesionUsuario(id: nuevaLlave);
                              ProviderSesionesTerapia.crearSesionUsuario(
                                  nuevaSesionUsuario);
                              final List<Appointment> appointment =
                                  <Appointment>[];
                              CustomAppointment nuevoAppointment =
                                  new CustomAppointment(
                                id: widget.sesionesTerapia.length - 1,
                                startTime: widget.selectedAppointment.startTime,
                                endTime: widget.selectedAppointment.endTime,
                                color: Color(0xFFFF637D),
                                notes: '',
                                isAllDay: false,
                                subject: virtual
                                    ? "Sesión Virtual"
                                    : "Sesion Presencial - Consultorio:" +
                                        nueva.consultorio.consultorio,
                              );
                              appointment.add(nuevoAppointment);
                              widget.events.appointments.add(appointment[0]);
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration duration) {
                                widget.events.notifyListeners(
                                    CalendarDataSourceAction.add, appointment);
                              });
                              print(widget.events.appointments.length);
                              widget.funcionActualizar(
                                  widget.sesionesTerapia,
                                  widget.events.appointments,
                                  widget.events,
                                  widget.events.appointments);
                            },
                            width: 120.0,
                          ),
                  ]),
                ))));
  }
}
