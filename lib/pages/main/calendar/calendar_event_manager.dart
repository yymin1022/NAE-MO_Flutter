import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:todo_project/pages/main/calendar/calendar_event.dart';
import 'package:todo_project/util/datetime_util.dart';

class CalendarEventManager {
  factory CalendarEventManager() {
    return _instance;
  }
  CalendarEventManager._privateConstructor();
  static final CalendarEventManager _instance = CalendarEventManager._privateConstructor();

  Future<List<CalendarEvent>> getCalendarEventsToday() async {
    var today = DatetimeUtil().getToday();
    var tomorrow = today.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
    return getCalendarEvents(today, tomorrow);
  }

  Future<List<CalendarEvent>> getCalendarEvents(DateTime from, DateTime to) async {
    var googleSignIn = GoogleSignIn(scopes: [CalendarApi.calendarScope]);
    await googleSignIn.signInSilently();
    var httpClient = await googleSignIn.authenticatedClient();

    if (httpClient == null) {
      throw Exception("Google login unavailable");
    }

    var calendarApi = CalendarApi(httpClient);
    var calendarList = await calendarApi.calendarList.list();
    var eventList = <CalendarEvent>[];

    if (calendarList.items != null) {
      for (var calendarEntry in calendarList.items!) {
        if (calendarEntry.id != null) {
          var events = await calendarApi.events.list(
            calendarEntry.id!,
            timeMin: from.toUtc(),
            timeMax: to.toUtc(),
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