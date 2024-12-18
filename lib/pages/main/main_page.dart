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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Listener(
        onPointerUp: (_) {
          _handleScrollSnap();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: const Row(
            children: [
              CalendarView(),
              TimeListview(),
              TodoView()
            ],
          ),
        ),
      ),
    );
  }

  void _handleScrollSnap() {
    var curScrollPosition = _scrollController.offset;
    var maxScrollPosition = _scrollController.position.maxScrollExtent;
    var curScrollRatio = curScrollPosition / maxScrollPosition * 100;

    if(curScrollRatio < 50) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.animateTo(
        maxScrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}