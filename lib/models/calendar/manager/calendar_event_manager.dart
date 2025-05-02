import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:todo_project/models/calendar/calendar_event.dart';
import 'package:todo_project/util/datetime_util.dart';
import 'package:todo_project/util/naemo_constants.dart';

class CalendarEventManager {
  factory CalendarEventManager() { return _instance; }
  CalendarEventManager._privateConstructor();
  static final CalendarEventManager _instance = CalendarEventManager._privateConstructor();

  /// Calendar Event List를 시간대별 List로 변환해 반환하는 함수
  List<List<CalendarEvent>> getCalendarEventsPerHour(List<CalendarEvent> events) {
    // 0시 ~ 23시 까지의 시간대별 Event List를 담기 위한 List
    var timeList = List<List<CalendarEvent>>.generate(
        NaemoConstants.timeSlotCount,
        (_) => List<CalendarEvent>.empty(growable: true));

    // Event List를 From 시간 순으로 정렬
    events.sort((eventA, eventB) => eventA.from.compareTo(eventB.from));

    // 오늘 날짜
    var todayDate = DatetimeUtil().getToday();
    // 각 Event 항목을 시간대별 Time List에 추가
    for(var event in events) {
      // UTC 시간 기준으로 데이터가 구성되었으므로,
      // 9H를 더해 KST로 변환
      var eventFrom = event.from.add(const Duration(hours: 9));
      var eventTo = event.to.add(const Duration(hours: 9));

      // From/To 시간 값
      var eventTimeHourFrom = eventFrom.hour;
      var eventTimeHourTo = eventTo.hour;

      // 오늘 이전의 날짜부터 이어지는 Event인 경우,
      // 오늘의 시작 시간을 00:00로 가정
      if(eventFrom.day < todayDate.day) {
        eventTimeHourFrom = 0;
      }
      // 오늘 이후의 날짜까지 이어지는 Event인 경우,
      // 오늘의 종료 시간을 23:59로 가정
      if(todayDate.day < eventTo.day) {
        eventTimeHourTo = 23;
      }

      if(eventTimeHourTo == eventTimeHourFrom) {
        // 하나의 시간대에 속하는 Event인 경우, (ex. 11:30 - 11:45)
        // 해당하는 시간대 Time List에 추가
        timeList[eventTimeHourFrom].add(event);
      } else {
        // 여러 시간대에 걸친 Event인 경우, (ex. 11:30 - 12:30, 18:00 - 20:00)
        for(var time = eventTimeHourFrom; time <= eventTimeHourTo; time++) {
          timeList[time].add(event);
        }
      }
    }

    return timeList;
  }

  /// 오늘 날짜에 해당하는 Calendar Event List를 반환하는 함수
  Future<List<CalendarEvent>> getCalendarEventsToday() async {
    // 오늘 날짜
    var todayDate = DatetimeUtil().getToday();

    // 오늘 날짜의 0시 0분 0초 시간으로 From 지정
    var dateFrom = DateTime(todayDate.year, todayDate.month, todayDate.day);
    // 오늘 날짜의 23시 59분 59초로 To 지정
    var dateTo = dateFrom.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));

    return getCalendarEvents(dateFrom, dateTo);
  }

  /// 내일 날짜에 해당하는 Calendar Event List를 반환하는 함수
  Future<List<CalendarEvent>> getCalendarEventsTomorrow() async {
    // 내일 날짜
    var tomorrowDate = DatetimeUtil().getTomorrow();

    // 내일 날짜의 0시 0분 0초 시간으로 From 지정
    var dateFrom = DateTime(tomorrowDate.year, tomorrowDate.month, tomorrowDate.day);
    // 내일 날짜의 23시 59분 59초로 To 지정
    var dateTo = dateFrom.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));

    return getCalendarEvents(dateFrom, dateTo);
  }

  /// 어제 날짜에 해당하는 Calendar Event List를 반환하는 함수
  Future<List<CalendarEvent>> getCalendarEventsYesterday() async {
    // 어제 날짜
    var yesterdayDate = DatetimeUtil().getYesterday();

    // 어제 날짜의 0시 0분 0초 시간으로 From 지정
    var dateFrom = DateTime(yesterdayDate.year, yesterdayDate.month, yesterdayDate.day);
    // 어제 날짜의 23시 59분 59초로 To 지정
    var dateTo = dateFrom.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));

    return getCalendarEvents(dateFrom, dateTo);
  }

  /// [from] 및 [to] 구간에 해당하는 Calandar Event List를 반환하는 함수
  Future<List<CalendarEvent>> getCalendarEvents(DateTime from, DateTime to) async {
    // Google 로그인 w/ Calendar API Scope
    // Scope를 지정해야 해당 리소스에 접근하기 위한 권한이 주어짐
    var googleSignIn = GoogleSignIn(scopes: [CalendarApi.calendarScope]);
    var googleUser = await googleSignIn.signIn();
    if(googleUser == null) {
      throw Exception("Google Sign In Failed");
    }

    // API Client 확인
    var client = await googleSignIn.authenticatedClient();
    if(client == null) {
      throw Exception("Google login unavailable");
    }

    // Calendar API 호출
    var calendarApi = CalendarApi(client);
    var calendarList = await calendarApi.calendarList.list();
    var eventList = List<CalendarEvent>.empty(growable: true);

    if(calendarList.items != null) {
      for(var calendarEntry in calendarList.items!) {
        if(calendarEntry.id != null) {
          // Calendar API로부터 각 Event 정보 불러오기
          var eventsFromCalendarEntry = await calendarApi.events.list(
            calendarEntry.id!,
            timeMin: from.toUtc(),
            timeMax: to.toUtc(),
            singleEvents: true,
            orderBy: 'startTime',
          );

          // 불러온 Event를 CalendarEvent 객체로 Wrapping하여 리스트에 추가
          eventList.addAll(
            (eventsFromCalendarEntry.items ?? [])
              .map((event) => CalendarEvent.fromEvent(event))
              .toList());
        }
      }
    }

    return eventList;
  }
}