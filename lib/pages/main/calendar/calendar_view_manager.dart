import 'package:todo_project/pages/main/calendar/calendar_event.dart';
import 'package:todo_project/pages/main/calendar/calendar_item.dart';
import 'package:todo_project/theme/naemo_color.dart';

class CalendarViewManager {
  factory CalendarViewManager() { return _instance; }
  CalendarViewManager._privateConstructor();
  static final CalendarViewManager _instance = CalendarViewManager._privateConstructor();

  CalendarItem getCalendarItem(CalendarEvent event) {
    var bgColor = NaemoColor.category1;
    var eventStart = event.start;
    var eventTitle = event.title;
    return CalendarItem(itemColor: bgColor, title: eventTitle);
  }
}