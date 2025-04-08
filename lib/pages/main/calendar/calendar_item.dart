import 'package:flutter/material.dart';
import 'package:todo_project/pages/main/calendar/calendar_event.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.itemColor,
    required this.idx,
    required this.event
  });

  final Color itemColor;
  final int idx;
  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor,
      height: 20,
      width: double.maxFinite,
      child: Text(
        event.title,
        textAlign: TextAlign.end,
      ),
    );
  }
}
