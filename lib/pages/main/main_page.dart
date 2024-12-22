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
  final ScrollController _calendarScrollController = ScrollController();
  final ScrollController _pageScrollController = ScrollController();
  final ScrollController _timeScrollController = ScrollController();
  final ScrollController _todoScrollController = ScrollController();
  bool isCalendarEnabled = true;

  @override
  void initState() {
    super.initState();

    _calendarScrollController.addListener(_syncScroll);
    _timeScrollController.addListener(_syncScroll);
    _todoScrollController.addListener(_syncScroll);
  }

  @override
  void dispose() {
    _calendarScrollController.removeListener(_syncScroll);
    _timeScrollController.removeListener(_syncScroll);
    _todoScrollController.removeListener(_syncScroll);
    _calendarScrollController.dispose();
    _pageScrollController.dispose();
    _timeScrollController.dispose();
    _todoScrollController.dispose();
    super.dispose();
  }

  void _syncScroll() {
    if(_calendarScrollController.hasClients
        && _timeScrollController.hasClients
        && _todoScrollController.hasClients) {
      if(isCalendarEnabled) {
        _timeScrollController.jumpTo(_calendarScrollController.offset);
        _todoScrollController.jumpTo(_calendarScrollController.offset);
      } else {
        _calendarScrollController.jumpTo(_todoScrollController.offset);
        _timeScrollController.jumpTo(_todoScrollController.offset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Listener(
        onPointerUp: (_) {
          _handleScrollSnap(_pageScrollController.offset);
        },
        child: SingleChildScrollView(
          controller: _pageScrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if(!isCalendarEnabled) _handleScrollSnap(0);
                },
                child: CalendarView(
                  isPageEnabled: isCalendarEnabled,
                  scrollController: _calendarScrollController,
                )
              ),
              TimeListview(
                scrollController: _timeScrollController,
              ),
              GestureDetector(
                onTap: () {
                  if(isCalendarEnabled) _handleScrollSnap(_pageScrollController.position.maxScrollExtent);
                },
                child: TodoView(
                  isPageEnabled: !isCalendarEnabled,
                  scrollController: _todoScrollController,
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleScrollSnap(double curScrollPosition) {
    var maxScrollPosition = _pageScrollController.position.maxScrollExtent;
    var curScrollRatio = curScrollPosition / maxScrollPosition * 100;

    setState(() {
      if(curScrollRatio < 50) {
        isCalendarEnabled = true;
        _pageScrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        isCalendarEnabled = false;
        _pageScrollController.animateTo(
          maxScrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

  }
}