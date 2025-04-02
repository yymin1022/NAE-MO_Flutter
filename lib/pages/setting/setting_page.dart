import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});

  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Text("Setting"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Go to main"))
          ],
        ));
  }
}
