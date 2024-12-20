import 'package:flutter/material.dart';
import 'package:todo_project/pages/main/todo/todo_item.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key, required this.isPageEnabled});
  final bool isPageEnabled;

  @override
  State<StatefulWidget> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final colorList = [Colors.green, Colors.white];
  final itemCnt = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 120,
      color: widget.isPageEnabled ? Colors.blue : Colors.white,
      child: ListView.builder(
          itemCount: itemCnt,
          itemBuilder: (_, idx) {
            return TodoItem(itemColor: colorList[idx % 2]);
          }
      ),
    );
  }
}