import 'package:googleapis/calendar/v3.dart';

class CalendarEvent {
  factory CalendarEvent.fromEvent(Event event) {
    var startDate = event.start?.dateTime ?? event.start?.date ?? DateTime.now();
    return CalendarEvent(title: event.summary ?? 'No Title', start: startDate);
  }

  factory CalendarEvent.empty() {
    return CalendarEvent(title: '', start: DateTime(1));
  }

  CalendarEvent({required this.title, required this.start});

  final String title;
  final DateTime start;
}
