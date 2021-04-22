import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CalendarioAgendar extends StatelessWidget {
  static const route = "/calendario";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es'),
        ],
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        home: Container(
            height: 1000, child: Expanded(child: CalendarAppointmentEditor())));
  }
}

class CalendarAppointmentEditor extends StatefulWidget {
  /// creates the appointment editor
  const CalendarAppointmentEditor({Key key}) : super(key: key);

  @override
  _CalendarAppointmentEditorState createState() =>
      _CalendarAppointmentEditorState();
}

class _CalendarAppointmentEditorState extends State<CalendarAppointmentEditor> {
  _CalendarAppointmentEditorState();

  List<Appointment> _appointments;
  bool _isMobile;

  List<Color> _colorCollection;
  List<String> _colorNames;
  _DataSource _events;
  Appointment _selectedAppointment;
  DateTime _startDate;
  DateTime _endDate;
  bool _isAllDay;
  String _subject = '';

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
    _appointments = _getAppointmentDetails();
    _events = _DataSource(_appointments);
    _selectedAppointment = null;
    _subject = '';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _isMobile = MediaQuery.of(context).size.width < 767;
    super.didChangeDependencies();
  }

  @override
  Widget build([BuildContext context]) {
    final Widget _calendar = Theme(

        /// The key set here to maintain the state,
        ///  when we change the parent of the widget
        key: _globalKey,
        data: temaSatpj(),
        child: _getAppointmentEditorCalendar(
            calendarController, _events, _onCalendarTapped, _onViewChanged));
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: kIsWeb && _screenHeight < 800
          ? Scrollbar(
              isAlwaysShown: true,
              controller: controller,
              child: ListView(
                controller: controller,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 600,
                    child: _calendar,
                  )
                ],
              ))
          : Container(color: Colors.white, child: _calendar),
    );
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
    print(calendarTapDetails.appointments == null);
    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      _selectedAppointment = calendarTapDetails.appointments[0];
    }

    final DateTime selectedDate = calendarTapDetails.date;
    final CalendarElement targetElement = calendarTapDetails.targetElement;

    /// To open the appointment editor for web,
    /// when the screen width is greater than 767.
    if (kIsWeb && !_isMobile) {
      final bool _isAppointmentTapped =
          calendarTapDetails.targetElement == CalendarElement.appointment;
      showDialog<Widget>(
          context: context,
          builder: (BuildContext context) {
            final List<Appointment> appointment = <Appointment>[];
            Appointment newAppointment;

            /// Creates a new appointment, which is displayed on the tapped
            /// calendar element, when the editor is opened.
            if (_selectedAppointment == null) {
              _isAllDay = calendarTapDetails.targetElement ==
                  CalendarElement.allDayPanel;
              _subject = '';
              final DateTime date = calendarTapDetails.date;
              _startDate = date;
              _endDate = date.add(const Duration(hours: 1));
              newAppointment = Appointment(
                startTime: _startDate,
                endTime: _endDate,
                color: Color(0xFFFF637D),
                isAllDay: _isAllDay,
                subject: _subject == '' ? '(No title)' : _subject,
              );
              appointment.add(newAppointment);
              _events.appointments.add(appointment[0]);

              SchedulerBinding.instance
                  .addPostFrameCallback((Duration duration) {
                _events.notifyListeners(
                    CalendarDataSourceAction.add, appointment);
              });
              _selectedAppointment = newAppointment;
            }
            return WillPopScope(
              onWillPop: () async {
                if (newAppointment != null) {
                  /// To remove the created appointment when the pop-up closed
                  /// without saving the appointment.
                  _events.appointments
                      .removeAt(_events.appointments.indexOf(newAppointment));
                  _events.notifyListeners(CalendarDataSourceAction.remove,
                      <Appointment>[]..add(newAppointment));
                }
                return true;
              },
              child: Center(
                  child: Container(
                      alignment: Alignment.center,
                      width: _isAppointmentTapped ? 400 : 500,
                      height: _isAppointmentTapped
                          ? _selectedAppointment.location == null ||
                                  _selectedAppointment.location.isEmpty
                              ? 150
                              : 200
                          : 390,
                      child: Theme(
                          data: temaSatpj(),
                          child: Card(
                            margin: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: _isAppointmentTapped
                                ? displayAppointmentDetails(
                                    context,
                                    targetElement,
                                    selectedDate,
                                    _selectedAppointment,
                                    _colorCollection,
                                    _colorNames,
                                    _events)
                                : PopUpAppointmentEditor(
                                    newAppointment,
                                    appointment,
                                    _events,
                                    _colorCollection,
                                    _colorNames,
                                    _selectedAppointment),
                          )))),
            );
          });
    } else {
      /// Navigates to the appointment editor page on mobile
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AppointmentEditor(
                _selectedAppointment,
                targetElement,
                selectedDate,
                _colorCollection,
                _colorNames,
                _events)),
      );
    }
  }

  /// Creates the required appointment details as a list, and created the data
  /// source for calendar with required information.
  List<Appointment> _getAppointmentDetails() {
    final List<Appointment> appointmentCollection = <Appointment>[];

    final DateTime today = DateTime.now();
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          appointmentCollection.add(Appointment(
            startTime: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour)),
            endTime: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour + 2)),
            color: Color(0xFF7EEFC6),
            startTimeZone: '',
            endTimeZone: '',
            notes: '',
            isAllDay: false,
            subject: 'Disponible',
          ));
        }
      }
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

/// Signature for callback which reports the picker value changed
typedef _PickerChanged = void Function(
    _PickerChangedDetails pickerChangedDetails);

/// Details for the [_PickerChanged].
class _PickerChangedDetails {
  _PickerChangedDetails({this.index, this.resourceId});

  final int index;

  final Object resourceId;
}

/// An object to set the appointment collection data source to collection, and
/// allows to add, remove or reset the appointment collection.
class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}

/// Formats the tapped appointment time text, to display on the pop-up view.
String _getAppointmentTimeText(Appointment selectedAppointment) {
  if (selectedAppointment.isAllDay) {
    return DateFormat('EEEE, MMM dd')
        .format(selectedAppointment.startTime)
        .toString();
  } else if (selectedAppointment.startTime.day !=
          selectedAppointment.endTime.day ||
      selectedAppointment.startTime.month !=
          selectedAppointment.endTime.month ||
      selectedAppointment.startTime.year != selectedAppointment.endTime.year) {
    String endFormat = 'EEEE, ';
    if (selectedAppointment.startTime.month !=
        selectedAppointment.endTime.month) {
      endFormat += 'MMM';
    }

    endFormat += ' dd hh:mm a';
    return DateFormat('EEEE, MMM dd hh:mm a')
            .format(selectedAppointment.startTime) +
        ' - ' +
        DateFormat(endFormat).format(selectedAppointment.endTime);
  } else {
    return DateFormat('EEEE, MMM dd hh:mm a')
            .format(selectedAppointment.startTime) +
        ' - ' +
        DateFormat('hh:mm a').format(selectedAppointment.endTime);
  }
}

/// Displays the tapped appointment details in a pop-up view.
Widget displayAppointmentDetails(
    BuildContext context,
    CalendarElement targetElement,
    DateTime selectedDate,
    Appointment selectedAppointment,
    List<Color> colorCollection,
    List<String> colorNames,
    CalendarDataSource events) {
  final Color defaultColor = Colors.black54;

  final Color defaultTextColor = Colors.black87;

  return ListView(padding: const EdgeInsets.all(0.0), children: <Widget>[
    ListTile(
        trailing: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit, color: kPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
            showDialog<Widget>(
                context: context,
                builder: (BuildContext context) {
                  return WillPopScope(
                      onWillPop: () async {
                        return true;
                      },
                      child: Theme(
                        data: temaSatpj(),
                        // ignore: prefer_const_literals_to_create_immutables
                        child: AppointmentEditorWeb(
                            selectedAppointment,
                            colorCollection,
                            colorNames,
                            events, <Appointment>[]),
                      ));
                });
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: kPrimaryColor),
          onPressed: () {
            events.appointments
                .removeAt(events.appointments.indexOf(selectedAppointment));
            events.notifyListeners(CalendarDataSourceAction.remove,
                <Appointment>[]..add(selectedAppointment));
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.close, color: kPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    )),
    ListTile(
        leading: Icon(
          Icons.lens,
          color: selectedAppointment.color,
          size: 20,
        ),
        title: Text(selectedAppointment.subject ?? '(No Text)',
            style: TextStyle(
                fontSize: 20,
                color: defaultTextColor,
                fontWeight: FontWeight.w400)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            _getAppointmentTimeText(selectedAppointment),
            style: TextStyle(
                fontSize: 15,
                color: defaultTextColor,
                fontWeight: FontWeight.w400),
          ),
        )),
    selectedAppointment.resourceIds == null ||
            selectedAppointment.resourceIds.isEmpty
        ? Container()
        : ListTile(
            leading: Icon(
              Icons.people,
              size: 20,
              color: defaultColor,
            ),
            title: Text(
                _getSelectedResourceText(
                    selectedAppointment.resourceIds, events.resources),
                style: TextStyle(
                    fontSize: 15,
                    color: defaultTextColor,
                    fontWeight: FontWeight.w400)),
          ),
    selectedAppointment.location == null || selectedAppointment.location.isEmpty
        ? Container()
        : ListTile(
            leading: Icon(
              Icons.location_on,
              size: 20,
              color: defaultColor,
            ),
            title: Text(selectedAppointment.location ?? '',
                style: TextStyle(
                    fontSize: 15,
                    color: defaultColor,
                    fontWeight: FontWeight.w400)),
          )
  ]);
}

/// Returns the selected resource display name based on the ids passed.
String _getSelectedResourceText(
    List<Object> resourceIds, List<CalendarResource> resourceCollection) {
  String resourceNames;
  for (int i = 0; i < resourceIds.length; i++) {
    final String name = resourceCollection
        .firstWhere((resource) => resource.id == resourceIds[i])
        .displayName;
    resourceNames = resourceNames == null ? name : resourceNames + ', ' + name;
  }

  return resourceNames;
}

///  The time zone picker element for the appointment editor with the available
///  time zone collection, and returns the selection time zone index
class _CalendarTimeZonePicker extends StatefulWidget {
  const _CalendarTimeZonePicker(
      this.backgroundColor, this.timeZoneCollection, this.selectedTimeZoneIndex,
      {this.onChanged});

  final Color backgroundColor;

  final List<String> timeZoneCollection;

  final int selectedTimeZoneIndex;

  final _PickerChanged onChanged;

  @override
  State<StatefulWidget> createState() {
    return _CalendarTimeZonePickerState();
  }
}

class _CalendarTimeZonePickerState extends State<_CalendarTimeZonePicker> {
  int _selectedTimeZoneIndex;

  @override
  void initState() {
    _selectedTimeZoneIndex = widget.selectedTimeZoneIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(_CalendarTimeZonePicker oldWidget) {
    _selectedTimeZoneIndex = widget.selectedTimeZoneIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaSatpj(),
        child: AlertDialog(
          content: Container(
              width: kIsWeb ? 500 : double.maxFinite,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: widget.timeZoneCollection.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        leading: Icon(
                          index == _selectedTimeZoneIndex
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: widget.backgroundColor,
                        ),
                        title: Text(widget.timeZoneCollection[index]),
                        onTap: () {
                          setState(() {
                            _selectedTimeZoneIndex = index;
                            widget
                                .onChanged(_PickerChangedDetails(index: index));
                          });

                          // ignore: always_specify_types
                          Future.delayed(const Duration(milliseconds: 200), () {
                            // When task is over, close the dialog
                            Navigator.pop(context);
                          });
                        },
                      ));
                },
              )),
        ));
  }
}

/// Builds the appointment editor with minimal elements in a pop-up based on the
/// tapped calendar element.
class PopUpAppointmentEditor extends StatefulWidget {
  const PopUpAppointmentEditor(
      this.newAppointment,
      this.appointment,
      this.events,
      this.colorCollection,
      this.colorNames,
      this.selectedAppointment);

  final Appointment newAppointment;

  final List<Appointment> appointment;

  final CalendarDataSource events;

  final List<Color> colorCollection;

  final List<String> colorNames;

  final Appointment selectedAppointment;

  @override
  _PopUpAppointmentEditorState createState() => _PopUpAppointmentEditorState();
}

class _PopUpAppointmentEditorState extends State<PopUpAppointmentEditor> {
  DateTime _startDate;
  DateTime _endDate;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  bool _isAllDay;
  String _subject = '';
  List<Object> _resourceIds;

  @override
  void initState() {
    _updateAppointmentProperties();
    super.initState();
  }

  @override
  void didUpdateWidget(PopUpAppointmentEditor oldWidget) {
    _updateAppointmentProperties();
    super.didUpdateWidget(oldWidget);
  }

  /// Updates the required editor's default field
  void _updateAppointmentProperties() {
    _startDate = widget.selectedAppointment.startTime;
    _endDate = widget.selectedAppointment.endTime;
    _isAllDay = widget.selectedAppointment.isAllDay;
    _subject = widget.selectedAppointment.subject == '(No title)'
        ? ''
        : widget.selectedAppointment.subject;
    _resourceIds = widget.selectedAppointment.resourceIds;

    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Colors.black54;

    final Color defaultTextColor = Colors.black87;

    final Widget _startDatePicker = RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(DateFormat('MMM dd, yyyy').format(_startDate),
          style:
              TextStyle(fontWeight: FontWeight.w500, color: defaultTextColor),
          textAlign: TextAlign.left),
      onPressed: () async {
        final DateTime date = await showDatePicker(
            context: context,
            initialDate: _startDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            builder: (BuildContext context, Widget child) {
              /// Theme widget used to apply the theme and primary color to the
              /// date picker.
              return Theme(
                /// The themedata created based
                ///  on the selected theme and primary color.
                data: temaSatpj(),
                child: child,
              );
            });

        if (date != null && date != _startDate) {
          setState(() {
            final Duration difference = _endDate.difference(_startDate);
            _startDate = DateTime(date.year, date.month, date.day,
                _startTime.hour, _startTime.minute, 0);
            _endDate = _startDate.add(difference);
            _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
          });
        }
      },
    );

    final Widget _startTimePicker = RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        DateFormat('hh:mm a').format(_startDate),
        style: TextStyle(fontWeight: FontWeight.w500, color: defaultTextColor),
        textAlign: TextAlign.left,
      ),
      onPressed: () async {
        final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime:
                TimeOfDay(hour: _startTime.hour, minute: _startTime.minute),
            builder: (BuildContext context, Widget child) {
              /// Theme widget used to apply the theme and primary color to the
              /// time picker.
              return Theme(
                /// The themedata created based
                /// on the selected theme and primary color.
                data: temaSatpj(),
                child: child,
              );
            });

        if (time != null && time != _startTime) {
          setState(() {
            _startTime = time;
            final Duration difference = _endDate.difference(_startDate);
            _startDate = DateTime(_startDate.year, _startDate.month,
                _startDate.day, _startTime.hour, _startTime.minute, 0);
            _endDate = _startDate.add(difference);
            _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
          });
        }
      },
    );

    final Widget _endTimePicker = RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        DateFormat('hh:mm a').format(_endDate),
        style: TextStyle(fontWeight: FontWeight.w500, color: defaultTextColor),
        textAlign: TextAlign.left,
      ),
      onPressed: () async {
        final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime:
                TimeOfDay(hour: _endTime.hour, minute: _endTime.minute),
            builder: (BuildContext context, Widget child) {
              /// Theme widget used to apply the theme and primary color to the
              /// date picker.
              return Theme(
                /// The themedata created based
                /// on the selected theme and primary color.
                data: temaSatpj(),
                child: child,
              );
            });

        if (time != null && time != _endTime) {
          setState(() {
            _endTime = time;
            final Duration difference = _endDate.difference(_startDate);
            _endDate = DateTime(_endDate.year, _endDate.month, _endDate.day,
                _endTime.hour, _endTime.minute, 0);
            if (_endDate.isBefore(_startDate)) {
              _startDate = _endDate.subtract(difference);
              _startTime =
                  TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
            }
          });
        }
      },
    );

    final Widget _endDatePicker = RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(DateFormat('MMM dd, yyyy').format(_endDate),
          style:
              TextStyle(fontWeight: FontWeight.w500, color: defaultTextColor),
          textAlign: TextAlign.left),
      onPressed: () async {
        final DateTime date = await showDatePicker(
            context: context,
            initialDate: _endDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            builder: (BuildContext context, Widget child) {
              /// Theme widget used to apply the theme and primary color to the
              /// date picker.
              return Theme(
                /// The themedata created based
                /// on the selected theme and primary color.
                data: temaSatpj(),
                child: child,
              );
            });

        if (date != null && date != _startDate) {
          setState(() {
            final Duration difference = _endDate.difference(_startDate);
            _endDate = DateTime(date.year, date.month, date.day, _endTime.hour,
                _endTime.minute, 0);
            if (_endDate.isBefore(_startDate)) {
              _startDate = _endDate.subtract(difference);
              _startTime =
                  TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
            }
          });
        }
      },
    );

    return ListView(padding: const EdgeInsets.all(0.0), children: <Widget>[
      Container(
          height: 50,
          child: ListTile(
            trailing: IconButton(
              icon: Icon(Icons.close, color: defaultColor),
              onPressed: () {
                if (widget.newAppointment != null &&
                    widget.events.appointments
                        .contains(widget.newAppointment)) {
                  /// To remove the created appointment, when the appointment editor
                  /// closed without saving the appointment.
                  widget.events.appointments.removeAt(widget.events.appointments
                      .indexOf(widget.newAppointment));
                  widget.events.notifyListeners(CalendarDataSourceAction.remove,
                      <Appointment>[]..add(widget.newAppointment));
                }

                Navigator.pop(context);
              },
            ),
          )),
      Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          child: ListTile(
            leading: const Text(''),
            title: TextField(
              autofocus: true,
              cursorColor: Colors.white,
              controller: TextEditingController(text: _subject),
              onChanged: (String value) {
                _subject = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                  fontSize: 20,
                  color: defaultTextColor,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                focusColor: Colors.white,
                border: const UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                        style: BorderStyle.solid)),
                hintText: 'Add title and time',
              ),
            ),
          )),
      Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          child: ListTile(
            leading: Container(
                width: 30,
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.access_time,
                  size: 20,
                  color: defaultColor,
                )),
            title: _isAllDay
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        _startDatePicker,
                        const Text(' - '),
                        _endDatePicker,
                        const Text(''),
                        const Text(''),
                      ])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        _startDatePicker,
                        _startTimePicker,
                        const Text(' - '),
                        _endTimePicker,
                        _endDatePicker,
                      ]),
          )),
      Container(
          height: 50,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: RawMaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    fillColor: kPrimaryColor,
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      if (widget.selectedAppointment != null ||
                          widget.newAppointment != null) {
                        if (widget.events.appointments.isNotEmpty &&
                            widget.events.appointments
                                .contains(widget.selectedAppointment)) {
                          widget.events.appointments.removeAt(widget
                              .events.appointments
                              .indexOf(widget.selectedAppointment));
                          widget.events.notifyListeners(
                              CalendarDataSourceAction.remove,
                              <Appointment>[]..add(widget.selectedAppointment));
                        }
                        if (widget.appointment.isNotEmpty &&
                            widget.appointment
                                .contains(widget.newAppointment)) {
                          widget.appointment.removeAt(widget.appointment
                              .indexOf(widget.newAppointment));
                        }
                      }

                      widget.appointment.add(Appointment(
                        startTime: _startDate,
                        endTime: _endDate,
                        color: Color(0xFFFF637D),
                        isAllDay: _isAllDay,
                        subject: _subject == '' ? '(No title)' : _subject,
                        resourceIds: _resourceIds,
                      ));

                      widget.events.appointments.add(widget.appointment[0]);

                      widget.events.notifyListeners(
                          CalendarDataSourceAction.add, widget.appointment);

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          )),
    ]);
  }
}

/// Builds the appointment editor with all the required elements in a pop-up
/// based on the tapped calendar element.
class AppointmentEditorWeb extends StatefulWidget {
  const AppointmentEditorWeb(this.selectedAppointment, this.colorCollection,
      this.colorNames, this.events,
      [this.appointment, this.newAppointment]);

  final Appointment newAppointment;

  final List<Appointment> appointment;

  final Appointment selectedAppointment;

  final List<Color> colorCollection;

  final List<String> colorNames;

  final CalendarDataSource events;

  @override
  _AppointmentEditorWebState createState() => _AppointmentEditorWebState();
}

class _AppointmentEditorWebState extends State<AppointmentEditorWeb> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  bool _isAllDay;
  String _subject = '';
  List<Object> _resourceIds;

  @override
  void initState() {
    _updateAppointmentProperties();
    super.initState();
  }

  @override
  void didUpdateWidget(AppointmentEditorWeb oldWidget) {
    _updateAppointmentProperties();
    super.didUpdateWidget(oldWidget);
  }

  /// Updates the required editor's default field
  void _updateAppointmentProperties() {
    _startDate = widget.selectedAppointment.startTime;
    _endDate = widget.selectedAppointment.endTime;
    _isAllDay = widget.selectedAppointment.isAllDay;
    _subject = widget.selectedAppointment.subject == '(No title)'
        ? ''
        : widget.selectedAppointment.subject;
    _resourceIds = widget.selectedAppointment.resourceIds;

    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Colors.black54;

    final Color defaultTextColor = Colors.black87;

    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Container(
        width: 600,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
        ),
        height: 560,
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  title: Text(
                    widget.selectedAppointment != null &&
                            widget.newAppointment == null
                        ? 'Edit appointment'
                        : 'New appointment',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: defaultTextColor),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: defaultColor),
                    onPressed: () {
                      if (widget.newAppointment != null &&
                          widget.events.appointments
                              .contains(widget.newAppointment)) {
                        /// To remove the created appointment when the pop-up closed
                        /// without saving the appointment.
                        widget.events.appointments.removeAt(widget
                            .events.appointments
                            .indexOf(widget.newAppointment));
                        widget.events.notifyListeners(
                            CalendarDataSourceAction.remove,
                            <Appointment>[]..add(widget.newAppointment));
                      }

                      Navigator.pop(context);
                    },
                  ),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                    title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 2, bottom: 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Title',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: defaultColor,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.start,
                              ),
                              TextField(
                                autofocus: true,
                                cursorColor: Colors.white,
                                controller:
                                    TextEditingController(text: _subject),
                                onChanged: (String value) {
                                  _subject = value;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: defaultTextColor,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  isDense: true,
                                  focusColor: Colors.white,
                                  border: const UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                          style: BorderStyle.solid)),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Start',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: defaultColor,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.start,
                            ),
                            TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: (_isAllDay
                                          ? DateFormat('dd/MM/yyyy')
                                          : DateFormat('dd/MM/yy h:mm a'))
                                      .format(_startDate)),
                              onChanged: (String value) {
                                _startDate = DateTime.parse(value);
                                _startTime = TimeOfDay(
                                    hour: _startDate.hour,
                                    minute: _startDate.minute);
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: defaultTextColor,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                isDense: true,
                                suffix: Container(
                                  height: 20,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      ButtonTheme(
                                          minWidth: 50.0,
                                          child: TextButton(
                                            onPressed: () async {
                                              final DateTime date =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: _startDate,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100),
                                                      builder:
                                                          (BuildContext context,
                                                              Widget child) {
                                                        return Theme(
                                                          data: temaSatpj(),
                                                          child: child,
                                                        );
                                                      });

                                              if (date != null &&
                                                  date != _startDate) {
                                                setState(() {
                                                  final Duration difference =
                                                      _endDate.difference(
                                                          _startDate);
                                                  _startDate = DateTime(
                                                      date.year,
                                                      date.month,
                                                      date.day,
                                                      _startTime.hour,
                                                      _startTime.minute,
                                                      0);
                                                  _endDate = _startDate
                                                      .add(difference);
                                                  _endTime = TimeOfDay(
                                                      hour: _endDate.hour,
                                                      minute: _endDate.minute);
                                                });
                                              }
                                            },
                                            child: Icon(
                                              Icons.date_range,
                                              color: defaultColor,
                                              size: 20,
                                            ),
                                          )),
                                      _isAllDay
                                          ? Text('')
                                          : ButtonTheme(
                                              minWidth: 50.0,
                                              child: TextButton(
                                                child: Icon(
                                                  Icons.access_time,
                                                  color: defaultColor,
                                                  size: 20,
                                                ),
                                                onPressed: () async {
                                                  final TimeOfDay time =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay(
                                                              hour: _startTime
                                                                  .hour,
                                                              minute: _startTime
                                                                  .minute),
                                                          builder: (BuildContext
                                                                  context,
                                                              Widget child) {
                                                            return Theme(
                                                              data: ThemeData
                                                                  .light(),
                                                              child: child,
                                                            );
                                                          });

                                                  if (time != null &&
                                                      time != _startTime) {
                                                    setState(() {
                                                      _startTime = time;
                                                      final Duration
                                                          difference =
                                                          _endDate.difference(
                                                              _startDate);
                                                      _startDate = DateTime(
                                                          _startDate.year,
                                                          _startDate.month,
                                                          _startDate.day,
                                                          _startTime.hour,
                                                          _startTime.minute,
                                                          0);
                                                      _endDate = _startDate
                                                          .add(difference);
                                                      _endTime = TimeOfDay(
                                                          hour: _endDate.hour,
                                                          minute:
                                                              _endDate.minute);
                                                    });
                                                  }
                                                },
                                              ))
                                    ],
                                  ),
                                ),
                                focusColor: Colors.white,
                                border: const UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                        style: BorderStyle.solid)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('End',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: defaultColor,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.start),
                            TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: (_isAllDay
                                          ? DateFormat('dd/MM/yyyy')
                                          : DateFormat('dd/MM/yy h:mm a'))
                                      .format(_endDate)),
                              onChanged: (String value) {
                                _endDate = DateTime.parse(value);
                                _endTime = TimeOfDay(
                                    hour: _endDate.hour,
                                    minute: _endDate.minute);
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: defaultTextColor,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                isDense: true,
                                suffix: Container(
                                  height: 20,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ButtonTheme(
                                          minWidth: 50.0,
                                          child: TextButton(
                                            child: Icon(
                                              Icons.date_range,
                                              color: defaultColor,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              final DateTime date =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: _endDate,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100),
                                                      builder:
                                                          (BuildContext context,
                                                              Widget child) {
                                                        return Theme(
                                                          data: temaSatpj(),
                                                          child: child,
                                                        );
                                                      });

                                              if (date != null &&
                                                  date != _endDate) {
                                                setState(() {
                                                  final Duration difference =
                                                      _endDate.difference(
                                                          _startDate);
                                                  _endDate = DateTime(
                                                      date.year,
                                                      date.month,
                                                      date.day,
                                                      _endTime.hour,
                                                      _endTime.minute,
                                                      0);
                                                  if (_endDate
                                                      .isBefore(_startDate)) {
                                                    _startDate = _endDate
                                                        .subtract(difference);
                                                    _startTime = TimeOfDay(
                                                        hour: _startDate.hour,
                                                        minute:
                                                            _startDate.minute);
                                                  }
                                                });
                                              }
                                            },
                                          )),
                                      _isAllDay
                                          ? Text('')
                                          : ButtonTheme(
                                              minWidth: 50.0,
                                              child: TextButton(
                                                child: Icon(
                                                  Icons.access_time,
                                                  color: defaultColor,
                                                  size: 20,
                                                ),
                                                onPressed: () async {
                                                  final TimeOfDay time =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay(
                                                              hour:
                                                                  _endTime.hour,
                                                              minute: _endTime
                                                                  .minute),
                                                          builder: (BuildContext
                                                                  context,
                                                              Widget child) {
                                                            return Theme(
                                                              data: ThemeData
                                                                  .light(),
                                                              child: child,
                                                            );
                                                          });

                                                  if (time != null &&
                                                      time != _endTime) {
                                                    setState(() {
                                                      _endTime = time;
                                                      final Duration
                                                          difference =
                                                          _endDate.difference(
                                                              _startDate);
                                                      _endDate = DateTime(
                                                          _endDate.year,
                                                          _endDate.month,
                                                          _endDate.day,
                                                          _endTime.hour,
                                                          _endTime.minute,
                                                          0);
                                                      if (_endDate.isBefore(
                                                          _startDate)) {
                                                        _startDate =
                                                            _endDate.subtract(
                                                                difference);
                                                        _startTime = TimeOfDay(
                                                            hour:
                                                                _startDate.hour,
                                                            minute: _startDate
                                                                .minute);
                                                      }
                                                    });
                                                  }
                                                },
                                              ))
                                    ],
                                  ),
                                ),
                                focusColor: Colors.white,
                                border: const UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                        style: BorderStyle.solid)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: RawMaterialButton(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: defaultTextColor),
                          ),
                          onPressed: () {
                            if (widget.newAppointment != null) {
                              widget.events.appointments.removeAt(widget
                                  .events.appointments
                                  .indexOf(widget.newAppointment));
                              widget.events.notifyListeners(
                                  CalendarDataSourceAction.remove,
                                  <Appointment>[]..add(widget.newAppointment));
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: RawMaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          fillColor: kPrimaryColor,
                          child: const Text(
                            'SAVE',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            if (widget.selectedAppointment != null ||
                                widget.newAppointment != null) {
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
                              if (widget.appointment.isNotEmpty &&
                                  widget.appointment
                                      .contains(widget.newAppointment)) {
                                widget.appointment.removeAt(widget.appointment
                                    .indexOf(widget.newAppointment));
                              }

                              if (widget.newAppointment != null &&
                                  widget.events.appointments.isNotEmpty &&
                                  widget.events.appointments
                                      .contains(widget.newAppointment)) {
                                widget.events.appointments.removeAt(widget
                                    .events.appointments
                                    .indexOf(widget.newAppointment));
                                widget.events.notifyListeners(
                                    CalendarDataSourceAction.remove,
                                    <Appointment>[]
                                      ..add(widget.newAppointment));
                              }
                            }

                            widget.appointment.add(Appointment(
                                startTime: _startDate,
                                endTime: _endDate,
                                color: Color(0xFFFF637D),
                                isAllDay: _isAllDay,
                                subject:
                                    _subject == '' ? '(No title)' : _subject,
                                resourceIds: _resourceIds));

                            widget.events.appointments
                                .add(widget.appointment[0]);

                            widget.events.notifyListeners(
                                CalendarDataSourceAction.add,
                                widget.appointment);

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

/// Builds the appointment editor with all the required elements based on the
/// tapped calendar element for mobile.
class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor(this.selectedAppointment, this.targetElement,
      this.selectedDate, this.colorCollection, this.colorNames, this.events,
      [this.selectedResource]);

  final Appointment selectedAppointment;

  final CalendarElement targetElement;

  final DateTime selectedDate;

  final List<Color> colorCollection;

  final List<String> colorNames;

  final CalendarDataSource events;

  final CalendarResource selectedResource;

  @override
  _AppointmentEditorState createState() => _AppointmentEditorState();
}

class _AppointmentEditorState extends State<AppointmentEditor> {
  int _selectedColorIndex = 0;
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
      _selectedColorIndex =
          widget.colorCollection.indexOf(widget.selectedAppointment.color);
      _subject = widget.selectedAppointment.subject == '(No title)'
          ? ''
          : widget.selectedAppointment.subject;
      _notes = widget.selectedAppointment.notes;
      _resourceIds = widget.selectedAppointment.resourceIds;
    } else {
      _isAllDay = widget.targetElement == CalendarElement.allDayPanel;
      _selectedColorIndex = 0;
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
              backgroundColor: widget.colorCollection[_selectedColorIndex],
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
                      final List<Appointment> appointment = <Appointment>[];
                      if (widget.selectedAppointment != null) {
                        widget.events.appointments.removeAt(widget
                            .events.appointments
                            .indexOf(widget.selectedAppointment));
                        widget.events.notifyListeners(
                            CalendarDataSourceAction.remove,
                            <Appointment>[]..add(widget.selectedAppointment));
                      }
                      appointment.add(Appointment(
                          startTime: _startDate,
                          endTime: _endDate,
                          color: widget.colorCollection[_selectedColorIndex],
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
                                <Appointment>[]
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
