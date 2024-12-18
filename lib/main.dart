import "package:flutter/material.dart";
import "package:todo_project/pages/main/main_page.dart";
import "package:todo_project/util/firebase_util.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtil().initFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: "Flutter Demo Home Page"),
    );
  }
}