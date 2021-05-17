import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
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
  List<SesionUsuario> sesionesUsuario;
  Usuario usuario;
  @override
  initState() {
    usuario = widget.usuario;
    sesionesUsuario = widget.sesionesUsuario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: kIsWeb
            ? Row(
                children: [
                  Column(
                    children: [
                      (usuario.tipoUsuario != "Auxiliar Administrativo")
                          ? Container(
                              width: 300,
                              height: 150,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Sesión En Curso",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: new ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        kAccentColor)),
                              ))
                          : SizedBox(),
                      Expanded(
                        child: Container(
                          width: 300,
                          child: ScheduleCalendar(
                              sesionesUsuario: this.sesionesUsuario),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: MonthlyCalendar(
                          sesionesUsuario: this.sesionesUsuario)),
                ],
              )
            : Column(
                children: [
                  Container(
                    height: 100,
                    child:
                        ScheduleCalendar(sesionesUsuario: this.sesionesUsuario),
                  ),
                  Expanded(
                      child: MonthlyCalendar(
                          sesionesUsuario: this.sesionesUsuario)),
                ],
              ));
  }
}

class MonthlyCalendar extends StatefulWidget {
  /// Creates default getting started calendar
  const MonthlyCalendar({this.sesionesUsuario, key}) : super(key: key);
  final List<SesionUsuario> sesionesUsuario;
  @override
  _MonthlyCalendarState createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  _MonthlyCalendarState();

  List<Color> _colorCollection;
  _MeetingDataSource _events;
  DateTime _minDate, _maxDate;
  CalendarController _calendarController;

  Usuario usuarioActual;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
  ];

  bool _showLeadingAndTrailingDates = true;
  bool _showDatePickerButton = true;
  bool _allowViewNavigation = true;

  ScrollController _controller;

  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  GlobalKey _globalKey;

  @override
  initState() {
    _showLeadingAndTrailingDates = true;
    _showDatePickerButton = true;
    _allowViewNavigation = true;
    _calendarController = CalendarController();
    _calendarController.view = CalendarView.month;
    _globalKey = GlobalKey();
    _controller = ScrollController();
    addAppointmentDetails();
    _events = _MeetingDataSource(<_Meeting>[]);
    _minDate = DateTime.now().subtract(const Duration(days: 365 ~/ 2));
    _maxDate = DateTime.now().add(const Duration(days: 365 ~/ 2));
    super.initState();
  }

  void longPressed(CalendarTapDetails calendarLongPressDetails) {
    print(calendarLongPressDetails.appointments.first.eventName);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text(" Long pressed")),
            content: Container(
                child: new Text("Date cell " +
                    DateFormat('dd MMM')
                        .format(calendarLongPressDetails.date)
                        .toString() +
                    " has been long pressed")),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('close'))
            ],
          );
        });
  }

  @override
  Widget build([BuildContext context]) {
    final Widget calendar = Theme(

        /// The key set here to maintain the state,
        ///  when we change the parent of the widget
        key: _globalKey,
        data: ThemeData.light(),
        child: _getGettingStartedCalendar(_calendarController, _events,
            _onViewChanged, _minDate, _maxDate, scheduleViewBuilder));

    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: _calendarController.view == CalendarView.month &&
                  kIsWeb &&
                  screenHeight < 800
              ? Scrollbar(
                  isAlwaysShown: true,
                  controller: _controller,
                  child: ListView(
                    controller: _controller,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 600,
                        child: calendar,
                      )
                    ],
                  ))
              : Container(color: Colors.white, child: calendar),
        )
      ]),
    );
  }

  /// The method called whenever the calendar view navigated to previous/next
  /// view or switched to different calendar view, based on the view changed
  /// details new appointment collection added to the calendar
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    final List<_Meeting> appointment = <_Meeting>[];
    //_events.appointments.clear();
    final Random random = Random();

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

  /// Returns the calendar widget based on the properties passed.
  SfCalendar _getGettingStartedCalendar(
      [CalendarController _calendarController,
      CalendarDataSource _calendarDataSource,
      ViewChangedCallback viewChangedCallback,
      DateTime _minDate,
      DateTime _maxDate,
      dynamic scheduleViewBuilder]) {
    return SfCalendar(
        controller: _calendarController,
        onTap: longPressed,
        dataSource: _calendarDataSource,
        allowedViews: _allowedViews,
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
        headerStyle: new CalendarHeaderStyle(
            backgroundColor: kPrimaryColor,
            textStyle:
                TextStyle(color: Colors.white, fontFamily: "Dubai-Bold")),
        viewHeaderStyle: new ViewHeaderStyle(
            backgroundColor: kPrimaryColor,
            dayTextStyle:
                TextStyle(color: Colors.white, fontFamily: "Dubai-Bold")),
        todayHighlightColor: kAccentColor,
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showTrailingAndLeadingDates: _showLeadingAndTrailingDates,
            appointmentDisplayCount: 4),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
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
    CalendarView.schedule
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
    _calendarController.view = CalendarView.schedule;
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
    //_events.appointments.clear();
    final Random random = Random();
    /*
    final List<DateTime> blockedDates = <DateTime>[];
    if (_calendarController.view == CalendarView.month ||
        _calendarController.view == CalendarView.timelineMonth) {
      for (int i = 0; i < 5; i++) {
        blockedDates.add(visibleDatesChangedDetails.visibleDates[
            random.nextInt(visibleDatesChangedDetails.visibleDates.length)]);
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (_calendarController.view == CalendarView.month ||
            _calendarController.view == CalendarView.timelineMonth) {
          _blackoutDates = blockedDates;
        } else {
          _blackoutDates?.clear();
        }
      });
    });*/
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

  void longPressed(CalendarTapDetails calendarLongPressDetails) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text(" Long pressed")),
            content: Container(
                child: new Text("Date cell " +
                    DateFormat('dd MMM')
                        .format(calendarLongPressDetails.date)
                        .toString() +
                    " has been long pressed")),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('close'))
            ],
          );
        });
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
        onTap: longPressed,
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
                TextStyle(color: Colors.black87, fontFamily: "Dubai-Bold")),
        headerStyle: new CalendarHeaderStyle(
            backgroundColor: kPrimaryColor,
            textStyle:
                TextStyle(color: Colors.white, fontFamily: "Dubai-Bold")),
        todayHighlightColor: kPrimaryColor,
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
          image: ExactAssetImage('images/' + monthName + '.png'),
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
