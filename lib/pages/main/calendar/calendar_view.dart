import 'package:flutter/material.dart';
import 'package:todo_project/models/calendar/calendar_event.dart';
import 'package:todo_project/pages/main/calendar/calendar_item.dart';
import 'package:todo_project/pages/main/calendar/manager/calendar_view_manager.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
    required this.isPageEnabled,
    required this.scrollController,
    required this.events,
  });

  final bool isPageEnabled;
  final ScrollController scrollController;
  final List<CalendarEvent> events;

  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final colorList = [Colors.blue, Colors.white];
  final itemCnt = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 120,
      color: widget.isPageEnabled ? Colors.blue : Colors.white,
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: itemCnt,
        itemBuilder: (_, idx) {
          CalendarEvent event;
          if (idx < 0 || idx >= widget.events.length) {
            event = CalendarEvent.empty();
          } else {
            event = widget.events[idx];
          }
          return CalendarViewManager().getCalendarItem(event);
        }
      ),
    );
  }
}