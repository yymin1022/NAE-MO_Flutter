import 'package:googleapis/calendar/v3.dart';

class CalendarEvent {
  factory CalendarEvent.fromEvent(Event event) {
    var timeFrom = event.start?.dateTime ?? event.start?.date ?? DateTime.now();
    var timeTo = event.end?.dateTime ?? event.end?.date ?? DateTime.now();
    return CalendarEvent(title: event.summary ?? 'No Title', from: timeFrom, to: timeTo);
  }

  factory CalendarEvent.empty() {
    return CalendarEvent(title: '', from: DateTime.now(), to: DateTime.now());
  }

  CalendarEvent({required this.title, required this.from, required this.to});

  final String title;
  final DateTime from;
  final DateTime to;
}
