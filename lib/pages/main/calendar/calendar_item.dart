import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({super.key, required this.itemColor, required this.idx});
  final Color itemColor;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor,
      height: 20,
      width: double.maxFinite,
      child: Text(
        idx.toString(),
          textAlign: TextAlign.end,
      ),
    );
  }
}