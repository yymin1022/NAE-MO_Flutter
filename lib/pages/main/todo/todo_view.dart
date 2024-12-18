import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key, required this.isPageEnabled});
  final bool isPageEnabled;

  @override
  State<StatefulWidget> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 120,
      color: widget.isPageEnabled ? Colors.green : Colors.white,
    );
  }
}