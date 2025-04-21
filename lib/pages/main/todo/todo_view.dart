import 'package:flutter/material.dart';
import 'package:todo_project/pages/main/todo/todo_item.dart';
import 'package:todo_project/theme/naemo_spacing.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key, required this.isPageEnabled, required this.scrollController});
  final bool isPageEnabled;
  final ScrollController scrollController;

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
      width: MediaQuery.of(context).size.width - (NaemoSpacing.mainDisabledListWidth + NaemoSpacing.timeListWidth),
      color: widget.isPageEnabled ? Colors.blue : Colors.white,
      child: ListView.builder(
          controller: widget.scrollController,
          itemCount: itemCnt,
          itemBuilder: (_, idx) {
            return TodoItem(idx: idx, itemColor: colorList[idx % 2]);
          }
      ),
    );
  }
}