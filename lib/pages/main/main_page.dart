import 'package:flutter/material.dart';
import 'package:todo_project/pages/main/calendar/calendar_view.dart';
import 'package:todo_project/pages/main/time_listview.dart';
import 'package:todo_project/pages/main/todo/todo_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  bool isCalendarEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Listener(
        onPointerUp: (_) {
          _handleScrollSnap(_scrollController.offset);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if(!isCalendarEnabled) _handleScrollSnap(0);
                },
                child: const CalendarView()
              ),
              const TimeListview(),
              GestureDetector(
                onTap: () {
                  if(isCalendarEnabled) _handleScrollSnap(_scrollController.position.maxScrollExtent);
                },
                child: const TodoView()
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleScrollSnap(double curScrollPosition) {
    var maxScrollPosition = _scrollController.position.maxScrollExtent;
    var curScrollRatio = curScrollPosition / maxScrollPosition * 100;

    setState(() {
      if(curScrollRatio < 50) {
        isCalendarEnabled = true;
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        isCalendarEnabled = false;
        _scrollController.animateTo(
          maxScrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

  }
}