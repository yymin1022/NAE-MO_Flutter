import 'package:firebase_core/firebase_core.dart';
import 'package:todo_project/firebase_options.dart';

class FirebaseUtil {
  FirebaseUtil._privateConstructor();
  static final FirebaseUtil _instance = FirebaseUtil._privateConstructor();

  factory FirebaseUtil() {
    return _instance;
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}