import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Login"),
          TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/main');
              },
              child: const Text("Go to main"))
        ],
      )
    );
  }
}
