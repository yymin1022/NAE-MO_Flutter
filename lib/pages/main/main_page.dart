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
      body: SingleChildScrollView(
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
    );
  }
}