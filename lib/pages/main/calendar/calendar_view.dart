import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      color: Colors.blue,
    );
  }
}