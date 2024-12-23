import 'package:flutter/material.dart';
import 'package:todo_project/pages/main/calendar/calendar_item.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.isPageEnabled, required this.scrollController});
  final bool isPageEnabled;
  final ScrollController scrollController;

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
          return CalendarItem(idx: idx, itemColor: colorList[idx % 2]);
        }
      ),
    );
  }
}