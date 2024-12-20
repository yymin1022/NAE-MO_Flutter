import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({super.key, required this.itemColor});
  final Color itemColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor,
      height: 20,
      width: double.maxFinite,
    );
  }
}