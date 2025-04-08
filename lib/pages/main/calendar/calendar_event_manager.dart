import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:todo_project/pages/main/calendar/calendar_event.dart';

class CalendarEventManager {
  factory CalendarEventManager() {
    return _instance;
  }
  CalendarEventManager._privateConstructor();
  static final CalendarEventManager _instance = CalendarEventManager._privateConstructor();

  Future<List<CalendarEvent>> getCalendarEvents() async {
    var googleSignIn = GoogleSignIn(scopes: [CalendarApi.calendarScope]);
    await googleSignIn.signInSilently();
    var httpClient = await googleSignIn.authenticatedClient();

    if (httpClient == null) {
      throw Exception("Google login unavailable");
    }

    var calendarApi = CalendarApi(httpClient);
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month - 1, now.day);
    var endDate = DateTime(now.year, now.month, now.day + 1)
        .subtract(const Duration(microseconds: 1));
    var calendarList = await calendarApi.calendarList.list();
    var eventList = <CalendarEvent>[];

    if (calendarList.items != null) {
      for (var calendarEntry in calendarList.items!) {
        if (calendarEntry.id != null) {
          var events = await calendarApi.events.list(
            calendarEntry.id!,
            timeMin: startDate.toUtc(),
            timeMax: endDate.toUtc(),
            singleEvents: true,
            orderBy: 'startTime',
          );
          eventList += (events.items ?? [])
              .map((event) => CalendarEvent.fromEvent(event))
              .toList();
        }
      }
    }

    return eventList;
  }
}