import 'package:flutter/material.dart';
import 'package:todo_project/theme/naemo_constants.dart';
import 'package:todo_project/theme/naemo_spacing.dart';

class TimeListview extends StatefulWidget {
  const TimeListview({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<StatefulWidget> createState() => _TimeListviewState();
}

class _TimeListviewState extends State<TimeListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: NaemoSpacing.timeListWidth,
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: NaemoConstants.timeSlotCount,
        itemBuilder: (_, idx) {
          return SizedBox(
            height: NaemoSpacing.timeListItemHeight,
            child: Text(
              idx.toString(),
              textAlign: TextAlign.center,
            ),
          );
        }
      )
    );
  }
}