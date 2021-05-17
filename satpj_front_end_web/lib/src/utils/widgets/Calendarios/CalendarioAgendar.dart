import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_sesiones_terapia.dart';
import 'package:satpj_front_end_web/src/providers/providers_usuarios/provider_usuarios.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/LoadingWidgets/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/dialogo_sesion_terapia.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'CustomAppointment.dart';

class CalendarioAgendar extends StatelessWidget {
  //static const route = "/calendario";
  CalendarioAgendar({@required this.paciente, @required this.practicante});
  final Paciente paciente;
  final Practicante practicante;
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
              child: Card(
                child: Flex(direction: Axis.vertical, children: [
                  Expanded(
                      child: CalendarAppointmentEditor(
                          paciente: this.paciente,
                          practicante: this.practicante))
                ]),
              ),
            )));
  }
}

class CalendarAppointmentEditor extends StatefulWidget {
  /// creates the appointment editor
  const CalendarAppointmentEditor({this.paciente, this.practicante, Key key})
      : super(key: key);
  final Paciente paciente;
  final Practicante practicante;
  @override
  _CalendarAppointmentEditorState createState() =>
      _CalendarAppointmentEditorState();
}

class _CalendarAppointmentEditorState extends State<CalendarAppointmentEditor> {
  _CalendarAppointmentEditorState();

  List<Appointment> _appointments;
  List<SesionTerapia> _sesionesTerapia;
  Horario _horarioPracticante;
  bool _isMobile;

  _DataSource _events;
  CustomAppointment _selectedAppointment;
  SesionTerapia _sesionTerapiaSeleccionada;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.week,
  ];

  ScrollController controller;
  CalendarController calendarController;

  /// Global key used to maintain the state,
  /// when we change the parent of the widget
  GlobalKey _globalKey;
  CalendarView _view;

  @override
  void initState() {
    _globalKey = GlobalKey();
    _isMobile = false;
    controller = ScrollController();
    calendarController = CalendarController();
    calendarController.view = CalendarView.week;
    _view = CalendarView.month;
    _selectedAppointment = null;
    _sesionTerapiaSeleccionada = null;
    super.initState();
  }

  Future<String> obtenerInformacion() async {
    _sesionesTerapia = await _getSesionesTerapia();
    _horarioPracticante = await _getHorario();
    _appointments =
        _getAppointmentDetails(_horarioPracticante, _sesionesTerapia);
    _events = _DataSource(_appointments);
    return Future.value("Data download successfully"); // return your response
  }

  @override
  void didChangeDependencies() {
    _isMobile = MediaQuery.of(context).size.width < 767;
    super.didChangeDependencies();
  }

  @override
  Widget build([BuildContext context]) {
    return FutureBuilder<String>(
      future: obtenerInformacion(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            final Widget _calendar = Theme(

                /// The key set here to maintain the state,
                ///  when we change the parent of the widget
                key: _globalKey,
                data: temaSatpj(),
                child: _getAppointmentEditorCalendar(calendarController,
                    _events, _onCalendarTapped, _onViewChanged));
            final double _screenHeight = MediaQuery.of(context).size.height;
            return Container(
              child: kIsWeb && _screenHeight < 800
                  ? Scrollbar(
                      isAlwaysShown: true,
                      controller: controller,
                      child: ListView(
                        controller: controller,
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            height: 1000,
                            child: _calendar,
                          )
                        ],
                      ))
                  : Container(color: Colors.white, child: _calendar),
            );
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  void actualizarInfo(
      List<SesionTerapia> sesionesNuevas,
      List<CustomAppointment> appointments,
      _DataSource events,
      List<dynamic> app2) {
    _sesionesTerapia = sesionesNuevas;
    _events = events;
    _events.appointments = app2;
  }

  /// The method called whenever the calendar view navigated to previous/next
  /// view or switched to different calendar view.
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    if (_view == calendarController.view || !kIsWeb) {
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _view = calendarController.view;
      });
    });
  }

  /// Navigates to appointment editor page when the calendar elements tapped
  /// other than the header, handled the editor fields based on tapped element.
  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    /// Condition added to open the editor, when the calendar elements tapped
    /// other than the header.
    if (calendarTapDetails.targetElement == CalendarElement.header ||
        calendarTapDetails.targetElement == CalendarElement.resourceHeader) {
      return;
    }

    _selectedAppointment = null;
    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      _selectedAppointment = calendarTapDetails.appointments[0];
      if (_selectedAppointment.id != -1) {
        _sesionTerapiaSeleccionada = _sesionesTerapia[_selectedAppointment.id];
      } else {
        _sesionTerapiaSeleccionada = null;
      }
    }

    final DateTime selectedDate = calendarTapDetails.date;
    final CalendarElement targetElement = calendarTapDetails.targetElement;

    /// To open the appointment editor for web,
    /// when the screen width is greater than 767.
    if (kIsWeb && !_isMobile) {
      final bool _isAppointmentTapped =
          calendarTapDetails.targetElement == CalendarElement.appointment;
      if (_isAppointmentTapped) {
        showDialog<Widget>(
            context: context,
            builder: (context) => DialogoAgendarSesionTerapia(
                  events: _events,
                  selectedAppointment: _selectedAppointment,
                  paciente: widget.paciente,
                  practicante: widget.practicante,
                  sesionesTerapia: _sesionesTerapia,
                  sesion: _sesionTerapiaSeleccionada,
                  horario: _horarioPracticante,
                  funcionActualizar: actualizarInfo,
                ));
      }
    } else {
      /// Navigates to the appointment editor page on mobile
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AppointmentEditor(
                _selectedAppointment, targetElement, selectedDate, _events)),
      );
    }
  }

  void asignacionSesionesAux(
      List<CustomAppointment> appointmentCollection,
      List<SesionTerapia> sesiones,
      DateTime posibleHoyInicio,
      DateTime posibleHoyFin) {
    bool noEncontrado = true;
    for (int i = 0; i < sesiones.length; i++) {
      if (sesiones[i].fecha.hour == posibleHoyInicio.hour &&
          sesiones[i].fecha.day == posibleHoyInicio.day &&
          sesiones[i].fecha.month == posibleHoyInicio.month &&
          sesiones[i].fecha.year == posibleHoyInicio.year) {
        appointmentCollection.add(CustomAppointment(
          id: i,
          startTime: posibleHoyInicio,
          endTime: posibleHoyFin,
          color: Color(0xFFFF637D),
          notes: '',
          isAllDay: false,
          subject: sesiones[i].virtual
              ? "Sesión Virtual"
              : "Sesion Presencial - Consultorio:" +
                  sesiones[i].consultorio.consultorio,
        ));
        i = sesiones.length;
        noEncontrado = false;
      }
    }
    if (noEncontrado) {
      appointmentCollection.add(CustomAppointment(
        id: -1,
        startTime: posibleHoyInicio,
        endTime: posibleHoyFin,
        color: Color(0xFF7EEFC6),
        notes: '',
        isAllDay: false,
        subject: "Disponible",
      ));
    }
  }

  void asignacionSesiones(List<CustomAppointment> appointmentCollection,
      List<SesionTerapia> sesiones, List<int> horas) {
    final DateTime hoy = DateTime.now();
    int horaValida = 0;
    for (horaValida = 0; horaValida < horas.length; horaValida++) {
      if (hoy.hour < horas[horaValida]) {
        DateTime posibleHoyInicio =
            new DateTime(hoy.year, hoy.month, hoy.day, horas[horaValida], 0);
        DateTime posibleHoyFin = posibleHoyInicio.add(new Duration(hours: 1));
        asignacionSesionesAux(
            appointmentCollection, sesiones, posibleHoyInicio, posibleHoyFin);
      }
    }
  }

  void asignarDia(
      DateTime nuevoDia,
      List<int> horasDia,
      List<CustomAppointment> appointmentCollection,
      List<SesionTerapia> sesiones) {
    for (int i = 0; i < horasDia.length; i++) {
      DateTime fechaIni = nuevoDia.add(new Duration(hours: horasDia[i]));
      DateTime fechaFin = nuevoDia.add(new Duration(hours: horasDia[i] + 1));
      asignacionSesionesAux(
          appointmentCollection, sesiones, fechaIni, fechaFin);
    }
  }

  Future<Horario> _getHorario() async {
    /*
    Horario horario = new Horario(
        lunes: "9;11;12;14;15",
        martes: "",
        miercoles: "",
        jueves: "17;18",
        viernes: "",
        sabado: "9;11");*/
    Horario horario =
        await ProviderAdministracionUsuarios.traerHorarioSeleccionado(
            widget.practicante.id);
    return horario;
  }

  Future<List<SesionTerapia>> _getSesionesTerapia() async {
    /*List<SesionTerapia> sesiones = <SesionTerapia>[];
    sesiones.add(new SesionTerapia(
        fecha: new DateTime(2021, 4, 29),
        hora: DateTime(2021, 4, 29, 17, 0),
        virtual: true));
    sesiones.add(new SesionTerapia(
        fecha: new DateTime(2021, 5, 3),
        hora: DateTime(2021, 5, 3, 11, 0),
        consultorio: "301",
        virtual: false));
    sesiones.add(new SesionTerapia(
        fecha: new DateTime(2021, 5, 6),
        hora: DateTime(2021, 5, 6, 17, 0),
        virtual: true));
    sesiones.add(new SesionTerapia(
        fecha: new DateTime(2021, 5, 10),
        hora: DateTime(2021, 5, 10, 11, 0),
        consultorio: "307",
        virtual: false));*/
    List<SesionUsuario> sesionesUsuarioPaciente =
        await ProviderSesionesTerapia.obtenerSesionesUsuario(
            widget.paciente.id);
    List<SesionTerapia> sesionesPaciente = <SesionTerapia>[];
    for (int i = 0; i < sesionesUsuarioPaciente.length; i++) {
      sesionesPaciente.add(sesionesUsuarioPaciente[i].sesionTerapia);
    }
    List<SesionUsuario> sesionesUsuarioPracticante =
        await ProviderSesionesTerapia.obtenerSesionesUsuario(
            widget.paciente.id);
    List<SesionTerapia> sesiones = List.from(sesionesPaciente);
    for (int i = 0; i < sesionesUsuarioPracticante.length; i++) {
      SesionTerapia sesionTerapia = sesionesUsuarioPracticante[i].sesionTerapia;
      sesiones.removeWhere((item) => item.id == sesionTerapia.id);
      sesionesPaciente.add(sesionTerapia);
    }
    return sesiones;
  }

  /// Creates the required appointment details as a list, and created the data
  /// source for calendar with required information.
  List<CustomAppointment> _getAppointmentDetails(
      Horario horario, List<SesionTerapia> sesiones) {
    final List<CustomAppointment> appointmentCollection = <CustomAppointment>[];
    Map<String, List<int>> horas = horario.forView();
    final DateTime hoy = DateTime.now();
    List<int> horasLunes = horas['lunes'];
    List<int> horasMartes = horas['martes'];
    List<int> horasMiercoles = horas['miercoles'];
    List<int> horasJueves = horas['jueves'];
    List<int> horasViernes = horas['viernes'];
    List<int> horasSabado = horas['sabado'];
    if (hoy.weekday == 1) {
      if (horasLunes != null)
        asignacionSesiones(appointmentCollection, sesiones, horasLunes);
      DateTime nuevo = new DateTime(hoy.year, hoy.month, hoy.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasMartes != null)
        asignarDia(nuevo, horasMartes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasMiercoles != null)
        asignarDia(nuevo, horasMiercoles, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasJueves != null)
        asignarDia(nuevo, horasJueves, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasViernes != null)
        asignarDia(nuevo, horasViernes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }
    if (hoy.weekday == 2) {
      if (horasMartes != null)
        asignacionSesiones(appointmentCollection, sesiones, horasMartes);
      DateTime nuevo = new DateTime(hoy.year, hoy.month, hoy.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasMiercoles != null)
        asignarDia(nuevo, horasMiercoles, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasJueves != null)
        asignarDia(nuevo, horasJueves, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasViernes != null)
        asignarDia(nuevo, horasViernes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }
    if (hoy.weekday == 3) {
      if (horasMiercoles != null)
        asignacionSesiones(appointmentCollection, sesiones, horasMiercoles);
      DateTime nuevo = new DateTime(hoy.year, hoy.month, hoy.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasJueves != null)
        asignarDia(nuevo, horasJueves, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasViernes != null)
        asignarDia(nuevo, horasViernes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }
    if (hoy.weekday == 4) {
      if (horasJueves != null)
        asignacionSesiones(appointmentCollection, sesiones, horasJueves);
      DateTime nuevo = new DateTime(hoy.year, hoy.month, hoy.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasViernes != null)
        asignarDia(nuevo, horasViernes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }
    if (hoy.weekday == 5) {
      if (horasViernes != null)
        asignacionSesiones(appointmentCollection, sesiones, horasViernes);
      DateTime nuevo = new DateTime(hoy.year, hoy.month, hoy.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }
    if (hoy.weekday == 6) {
      if (horasSabado != null)
        asignacionSesiones(appointmentCollection, sesiones, horasSabado);
    }
    //asignacion otra semana
    DateTime nuevo = hoy;
    for (int i = 0; i < 2; i++) {
      nuevo = new DateTime(nuevo.year, nuevo.month, nuevo.day, 0, 0);
      nuevo = nuevo.add(new Duration(days: 1));
      while (nuevo.weekday != 1) {
        nuevo = nuevo.add(new Duration(days: 1));
      }
      if (horasLunes != null)
        asignarDia(nuevo, horasLunes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasMartes != null)
        asignarDia(nuevo, horasMartes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasMiercoles != null)
        asignarDia(nuevo, horasMiercoles, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasJueves != null)
        asignarDia(nuevo, horasJueves, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasViernes != null)
        asignarDia(nuevo, horasViernes, appointmentCollection, sesiones);
      nuevo = nuevo.add(new Duration(days: 1));
      if (horasSabado != null)
        asignarDia(nuevo, horasSabado, appointmentCollection, sesiones);
    }

    return appointmentCollection;
  }

  /// Returns the calendar based on the properties passed.
  SfCalendar _getAppointmentEditorCalendar(
      [CalendarController _calendarController,
      CalendarDataSource _calendarDataSource,
      dynamic calendarTapCallback,
      ViewChangedCallback viewChangedCallback]) {
    return SfCalendar(
        controller: _calendarController,
        showNavigationArrow: kIsWeb,
        allowedViews: _allowedViews,
        showDatePickerButton: true,
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        onViewChanged: viewChangedCallback,
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            appointmentDisplayCount: 4),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }
}

/// An object to set the appointment collection data source to collection, and
/// allows to add, remove or reset the appointment collection.
class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<CustomAppointment> source;

  @override
  List<dynamic> get appointments => source;
}

/// Builds the appointment editor with all the required elements based on the
/// tapped calendar element for mobile.
class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor(this.selectedAppointment, this.targetElement,
      this.selectedDate, this.events,
      [this.selectedResource]);

  final CustomAppointment selectedAppointment;

  final CalendarElement targetElement;

  final DateTime selectedDate;

  final CalendarDataSource events;

  final CalendarResource selectedResource;

  @override
  _AppointmentEditorState createState() => _AppointmentEditorState();
}

class _AppointmentEditorState extends State<AppointmentEditor> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  bool _isAllDay;
  String _subject = '';
  String _notes = '';
  List<Object> _resourceIds;

  @override
  void initState() {
    _updateAppointmentProperties();
    super.initState();
  }

  @override
  void didUpdateWidget(AppointmentEditor oldWidget) {
    _updateAppointmentProperties();
    super.didUpdateWidget(oldWidget);
  }

  /// Updates the required editor's default field
  void _updateAppointmentProperties() {
    if (widget.selectedAppointment != null) {
      _startDate = widget.selectedAppointment.startTime;
      _endDate = widget.selectedAppointment.endTime;
      _isAllDay = widget.selectedAppointment.isAllDay;
      _subject = widget.selectedAppointment.subject == '(No title)'
          ? ''
          : widget.selectedAppointment.subject;
      _notes = widget.selectedAppointment.notes;
      _resourceIds = widget.selectedAppointment.resourceIds;
    } else {
      _isAllDay = widget.targetElement == CalendarElement.allDayPanel;
      _subject = '';
      _notes = '';

      final DateTime date = widget.selectedDate;
      _startDate = date;
      _endDate = date.add(const Duration(hours: 1));

      if (widget.selectedResource != null) {
        _resourceIds = <Object>[widget.selectedResource.id];
      }
    }

    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
  }

  Widget _getAppointmentEditor(
      BuildContext context, Color backgroundColor, Color defaultColor) {
    return Container(
        color: backgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              leading: const Text(''),
              title: TextField(
                controller: TextEditingController(text: _subject),
                onChanged: (String value) {
                  _subject = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 25,
                    color: defaultColor,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add title',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: Icon(
                  Icons.access_time,
                  color: defaultColor,
                ),
                title: Row(children: <Widget>[
                  const Expanded(
                    child: Text('All-day'),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: _isAllDay,
                            onChanged: (bool value) {
                              setState(() {
                                _isAllDay = value;
                              });
                            },
                          ))),
                ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                                DateFormat('EEE, MMM dd yyyy')
                                    .format(_startDate),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              final DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: temaSatpj(),
                                      child: child,
                                    );
                                  });

                              if (date != null && date != _startDate) {
                                setState(() {
                                  final Duration difference =
                                      _endDate.difference(_startDate);
                                  _startDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _startTime.hour,
                                      _startTime.minute,
                                      0);
                                  _endDate = _startDate.add(difference);
                                  _endTime = TimeOfDay(
                                      hour: _endDate.hour,
                                      minute: _endDate.minute);
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                                  child: Text(
                                    DateFormat('hh:mm a').format(_startDate),
                                    textAlign: TextAlign.right,
                                  ),
                                  onTap: () async {
                                    final TimeOfDay time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: _startTime.hour,
                                            minute: _startTime.minute),
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Theme(
                                            data: temaSatpj(),
                                            child: child,
                                          );
                                        });

                                    if (time != null && time != _startTime) {
                                      setState(() {
                                        _startTime = time;
                                        final Duration difference =
                                            _endDate.difference(_startDate);
                                        _startDate = DateTime(
                                            _startDate.year,
                                            _startDate.month,
                                            _startDate.day,
                                            _startTime.hour,
                                            _startTime.minute,
                                            0);
                                        _endDate = _startDate.add(difference);
                                        _endTime = TimeOfDay(
                                            hour: _endDate.hour,
                                            minute: _endDate.minute);
                                      });
                                    }
                                  })),
                    ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                              DateFormat('EEE, MMM dd yyyy').format(_endDate),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () async {
                              final DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: temaSatpj(),
                                      child: child,
                                    );
                                  });

                              if (date != null && date != _endDate) {
                                setState(() {
                                  final Duration difference =
                                      _endDate.difference(_startDate);
                                  _endDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _endTime.hour,
                                      _endTime.minute,
                                      0);
                                  if (_endDate.isBefore(_startDate)) {
                                    _startDate = _endDate.subtract(difference);
                                    _startTime = TimeOfDay(
                                        hour: _startDate.hour,
                                        minute: _startDate.minute);
                                  }
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                                  child: Text(
                                    DateFormat('hh:mm a').format(_endDate),
                                    textAlign: TextAlign.right,
                                  ),
                                  onTap: () async {
                                    final TimeOfDay time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: _endTime.hour,
                                            minute: _endTime.minute),
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Theme(
                                            data: temaSatpj(),
                                            child: child,
                                          );
                                        });

                                    if (time != null && time != _endTime) {
                                      setState(() {
                                        _endTime = time;
                                        final Duration difference =
                                            _endDate.difference(_startDate);
                                        _endDate = DateTime(
                                            _endDate.year,
                                            _endDate.month,
                                            _endDate.day,
                                            _endTime.hour,
                                            _endTime.minute,
                                            0);
                                        if (_endDate.isBefore(_startDate)) {
                                          _startDate =
                                              _endDate.subtract(difference);
                                          _startTime = TimeOfDay(
                                              hour: _startDate.hour,
                                              minute: _startDate.minute);
                                        }
                                      });
                                    }
                                  })),
                    ])),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            kIsWeb
                ? const Divider(
                    height: 1.0,
                    thickness: 1,
                  )
                : Container(),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.subject,
                color: defaultColor,
              ),
              title: TextField(
                controller: TextEditingController(text: _notes),
                cursorColor: Colors.white,
                onChanged: (String value) {
                  _notes = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: kIsWeb ? 1 : null,
                style: TextStyle(
                    fontSize: 18,
                    color: defaultColor,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build([BuildContext context]) {
    return Theme(
        data: temaSatpj(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xFFFF637D),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final List<CustomAppointment> appointment =
                          <CustomAppointment>[];
                      if (widget.selectedAppointment != null) {
                        widget.events.appointments.removeAt(widget
                            .events.appointments
                            .indexOf(widget.selectedAppointment));
                        widget.events.notifyListeners(
                            CalendarDataSourceAction.remove,
                            <CustomAppointment>[]
                              ..add(widget.selectedAppointment));
                      }
                      appointment.add(CustomAppointment(
                          startTime: _startDate,
                          endTime: _endDate,
                          color: Color(0xFFFF637D),
                          notes: _notes,
                          isAllDay: _isAllDay,
                          subject: _subject == '' ? '(No title)' : _subject,
                          resourceIds: _resourceIds));

                      widget.events.appointments.add(appointment[0]);

                      widget.events.notifyListeners(
                          CalendarDataSourceAction.add, appointment);
                      Navigator.pop(context);
                    })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[
                  _getAppointmentEditor(context, Colors.white, Colors.black87)
                ],
              ),
            ),
            floatingActionButton: kIsWeb
                ? null
                : widget.selectedAppointment == null
                    ? const Text('')
                    : FloatingActionButton(
                        onPressed: () {
                          if (widget.selectedAppointment != null) {
                            widget.events.appointments.removeAt(widget
                                .events.appointments
                                .indexOf(widget.selectedAppointment));
                            widget.events.notifyListeners(
                                CalendarDataSourceAction.remove,
                                <CustomAppointment>[]
                                  ..add(widget.selectedAppointment));
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(Icons.delete_outline,
                            color: Colors.white),
                        backgroundColor: Colors.white,
                      )));
  }
}
