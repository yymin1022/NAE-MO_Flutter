import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:provider/provider.dart";
import "package:todo_project/pages/login/AuthProvider.dart";
import "package:todo_project/pages/login/login_page.dart";
import "package:todo_project/pages/main/main_page.dart";
import "package:todo_project/pages/setting/setting_page.dart";
import "package:todo_project/util/firebase_util.dart";

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FirebaseUtil().initFirebase();

  FlutterNativeSplash.remove();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: authProvider.isLoggedIn ? '/main' : '/login',
      routes: {
        '/main': (context) => const MainPage(title: "Flutter Demo Home Page"),
        '/login': (context) => const LoginPage(title: "Login Page"),
        '/setting': (context) => const SettingPage(title: "Setting Page"),
      },
    );
  }
}