import 'package:flutter/material.dart';
import 'package:todo_project/models/calendar/calendar_event.dart';
import 'package:todo_project/theme/naemo_spacing.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.itemColor,
    required this.title
  });

  final Color itemColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor,
      height: NaemoSpacing.timeListItemHeight,
      child: Text(
        title,
        textAlign: TextAlign.end,
      ),
    );
  }
}
