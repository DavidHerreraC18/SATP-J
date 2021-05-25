import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:satpj_front_end_movil/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_movil/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_movil/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_movil/src/views/sesion_videollamadas/vista_llamada.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../tema.dart';

class CalendarioPrincipal extends StatefulWidget {
  //static const route = "/calendario";
  final List<SesionUsuario> sesionesUsuario;
  final Usuario usuario;
  const CalendarioPrincipal(
      {@required this.sesionesUsuario, @required this.usuario, key})
      : super(key: key);
  @override
  _CalendarioPrincipalState createState() => _CalendarioPrincipalState();
}

class _CalendarioPrincipalState extends State<CalendarioPrincipal> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 24),
            (widget.usuario.tipoUsuario != "Auxiliar Administrativo" &&
                    widget.usuario.tipoUsuario != "Acudiente" &&
                    widget.usuario.tipoUsuario != "Supervisor")
                ? Container(
                    width: double.infinity,
                    height: 75,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, VistaLlamada.route);
                      },
                      child: Text(
                        "Sesión En Curso",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: new ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kAccentColor)),
                    ))
                : SizedBox(),
            Expanded(
              child: ScheduleCalendar(sesionesUsuario: widget.sesionesUsuario),
            ),
          ],
        ));
  }
}

class ScheduleCalendar extends StatefulWidget {
  /// Creates default getting started calendar
  const ScheduleCalendar({this.sesionesUsuario, key}) : super(key: key);
  final List<SesionUsuario> sesionesUsuario;
  @override
  _ScheduleCalendarState createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  _ScheduleCalendarState();

  List<Color> _colorCollection;
  _MeetingDataSource _events;
  DateTime _minDate, _maxDate;
  CalendarController _calendarController;

  final List<CalendarView> _allowedViewsSche = <CalendarView>[
    CalendarView.schedule,
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
  ];

  bool _showLeadingAndTrailingDates = true;
  bool _showDatePickerButton = true;
  bool _allowViewNavigation = true;

  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  GlobalKey _globalKeySche;

  @override
  void initState() {
    _showLeadingAndTrailingDates = true;
    _showDatePickerButton = true;
    _allowViewNavigation = true;
    _calendarController = CalendarController();
    _calendarController.view = CalendarView.month;
    _globalKeySche = GlobalKey();
    addAppointmentDetails();
    cargarEventos();
    _minDate = DateTime.now().subtract(const Duration(days: 365 ~/ 2));
    _maxDate = DateTime.now().add(const Duration(days: 365 ~/ 2));
    super.initState();
  }

  cargarEventos() {
    _events = _MeetingDataSource(<_Meeting>[]);
    final Random random = Random();
    final List<_Meeting> appointment = <_Meeting>[];
    for (int i = 0; i < widget.sesionesUsuario.length; i++) {
      SesionUsuario sesionUsuario = widget.sesionesUsuario[i];
      SesionTerapia sesionTerapia = sesionUsuario.sesionTerapia;
      String sesionString = "Sesión ";
      sesionString = sesionString +
          ((sesionTerapia.virtual)
              ? "Virtual"
              : "Presencial Consultorio" +
                  sesionTerapia.consultorio.consultorio);
      DateTime startDate = new DateTime(
          sesionTerapia.fecha.year,
          sesionTerapia.fecha.month,
          sesionTerapia.fecha.day,
          sesionTerapia.fecha.hour,
          sesionTerapia.fecha.minute);

      appointment.add(_Meeting(
        sesionString,
        startDate,
        startDate.add(Duration(hours: 1)),
        _colorCollection[random.nextInt(_colorCollection.length)],
        false,
      ));
    }

    for (int i = 0; i < appointment.length; i++) {
      _events.appointments.add(appointment[i]);
    }

    /// Resets the newly created appointment collection to render
    /// the appointments on the visible dates.
    _events.notifyListeners(CalendarDataSourceAction.reset, appointment);
  }

  @override
  Widget build([BuildContext context]) {
    final Widget calendarSche = Theme(

        /// The key set here to maintain the state,
        ///  when we change the parent of the widget
        key: _globalKeySche,
        data: ThemeData.light(),
        child: _getGettingStartedCalendarSche(_calendarController, _events,
            _onViewChanged, _minDate, _maxDate, scheduleViewBuilder));

    //final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: Container(color: Colors.white, child: calendarSche),
        )
      ]),
    );
  }

  /// The method called whenever the calendar view navigated to previous/next
  /// view or switched to different calendar view, based on the view changed
  /// details new appointment collection added to the calendar
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    final List<_Meeting> appointment = <_Meeting>[];
    final Random random = Random();
    _events.appointments.clear();

    /// Creates new appointment collection based on
    /// the visible dates in calendar.
    for (int i = 0; i < widget.sesionesUsuario.length; i++) {
      SesionUsuario sesionUsuario = widget.sesionesUsuario[i];
      SesionTerapia sesionTerapia = sesionUsuario.sesionTerapia;
      String sesionString = "Sesión ";
      sesionString = sesionString +
          ((sesionTerapia.virtual)
              ? "Virtual"
              : "Presencial Consultorio" +
                  sesionTerapia.consultorio.consultorio);
      DateTime startDate = new DateTime(
          sesionTerapia.fecha.year,
          sesionTerapia.fecha.month,
          sesionTerapia.fecha.day,
          sesionTerapia.fecha.hour,
          sesionTerapia.fecha.minute);
      appointment.add(_Meeting(
        sesionString,
        startDate,
        startDate.add(Duration(hours: 1)),
        _colorCollection[random.nextInt(_colorCollection.length)],
        false,
      ));
    }

    for (int i = 0; i < appointment.length; i++) {
      _events.appointments.add(appointment[i]);
    }

    /// Resets the newly created appointment collection to render
    /// the appointments on the visible dates.
    _events.notifyListeners(CalendarDataSourceAction.reset, appointment);
  }

  /// Creates the required appointment details as a list.
  void addAppointmentDetails() {
    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF7EEFC6));
    _colorCollection.add(const Color(0xFFFF637D));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFF85ADEB));
    _colorCollection.add(const Color(0xFFFCF88C));
    _colorCollection.add(const Color(0xFF957DAD));
  }

  SfCalendar _getGettingStartedCalendarSche(
      [CalendarController _calendarController,
      CalendarDataSource _calendarDataSource,
      ViewChangedCallback viewChangedCallback,
      DateTime _minDate,
      DateTime _maxDate,
      dynamic scheduleViewBuilder]) {
    return SfCalendar(
        controller: _calendarController,
        dataSource: _calendarDataSource,
        allowedViews: _allowedViewsSche,
        scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
        showNavigationArrow: kIsWeb,
        showDatePickerButton: _showDatePickerButton,
        allowViewNavigation: _allowViewNavigation,
        onViewChanged: viewChangedCallback,
        blackoutDatesTextStyle: TextStyle(
            decoration: kIsWeb ? null : TextDecoration.lineThrough,
            color: Colors.red),
        minDate: _minDate,
        maxDate: _maxDate,
        appointmentTextStyle:
            TextStyle(color: Colors.black87, fontFamily: "Dubai"),
        viewHeaderStyle: new ViewHeaderStyle(
            backgroundColor: kPrimaryColor,
            dayTextStyle:
                TextStyle(color: Colors.white, fontFamily: "Dubai-Bold")),
        headerStyle: new CalendarHeaderStyle(
            backgroundColor: kPrimaryColor,
            textStyle:
                TextStyle(color: kAccentColor, fontFamily: "Dubai-Bold")),
        todayHighlightColor: kAccentColor,
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showTrailingAndLeadingDates: _showLeadingAndTrailingDates,
            appointmentDisplayCount: 4),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }
}

/// Returns the month name based on the month value passed from date.
String _getMonthDate(int month) {
  if (month == 01) {
    return 'Enero';
  } else if (month == 02) {
    return 'Febrero';
  } else if (month == 03) {
    return 'Marzo';
  } else if (month == 04) {
    return 'Abril';
  } else if (month == 05) {
    return 'Mayo';
  } else if (month == 06) {
    return 'Junio';
  } else if (month == 07) {
    return 'Julio';
  } else if (month == 08) {
    return 'Agosto';
  } else if (month == 09) {
    return 'Septiembre';
  } else if (month == 10) {
    return 'Octubre';
  } else if (month == 11) {
    return 'Noviembre';
  } else {
    return 'Diciembre';
  }
}

/// Returns the builder for schedule view.
Widget scheduleViewBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthDate(details.date.month);
  return Stack(
    children: [
      Image(
          image: AssetImage('lib/src/utils/images/' + monthName + '.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height),
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          monthName + ' ' + details.date.year.toString(),
          style: TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

/// An object to set the appointment collection data source to collection, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
