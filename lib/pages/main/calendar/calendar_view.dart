import 'package:flutter/material.dart';
import 'package:todo_project/models/calendar/calendar_event.dart';
import 'package:todo_project/pages/main/calendar/manager/calendar_view_manager.dart';
import 'package:todo_project/theme/naemo_spacing.dart';
import 'package:todo_project/util/naemo_constants.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
    required this.isPageEnabled,
    required this.scrollController,
    required this.events,
  });

  final bool isPageEnabled;
  final ScrollController scrollController;
  final List<List<CalendarEvent>> events;

  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final colorList = [Colors.blue, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - (NaemoSpacing.mainDisabledListWidth + NaemoSpacing.timeListWidth),
      color: widget.isPageEnabled ? Colors.blue : Colors.white,
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: NaemoConstants.timeSlotCount,
        itemBuilder: (_, idx) {
          if(widget.events.isEmpty || widget.events[idx].isEmpty) {
            return CalendarViewManager().getCalendarItem(CalendarEvent.empty());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: widget.events[idx].map((event) =>
              CalendarViewManager().getCalendarItem(event)).toList(),
          );
        }
      ),
    );
  }
}