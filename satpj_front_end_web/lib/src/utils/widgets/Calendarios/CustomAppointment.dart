import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomAppointment extends Appointment {
  int id;
  CustomAppointment(
      {DateTime startTime,
      DateTime endTime,
      String notes,
      String subject,
      Color color,
      bool isAllDay,
      List<Object> resourceIds,
      this.id})
      : super(
            startTime: startTime,
            endTime: endTime,
            notes: notes,
            subject: subject,
            color: color,
            isAllDay: isAllDay,
            resourceIds: resourceIds);
}
