class DatetimeUtil {
  factory DatetimeUtil() { return _instance; }
  DatetimeUtil._privateConstructor();
  static final DatetimeUtil _instance = DatetimeUtil._privateConstructor();

  DateTime getToday() {
    return DateTime.now();
  }

  int getTodayDay() {
    return getToday().day;
  }

  int getTodayMonth() {
    return getToday().month;
  }

  int getTodayYear() {
    return getToday().year;
  }

  int getCurrentHour() {
    return getToday().hour;
  }

  int getCurrentMinute() {
    return getToday().minute;
  }

  String getCurrentTimeString() {
    var today = getToday();
    return "${today.hour}:${today.minute}";
  }
}