import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/views/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCgBTb9no-amRTl_xVVb3NAlJoBhe4hWOw",
            authDomain: "fir-app-b0752.firebaseapp.com",
            projectId: "fir-app-b0752",
            storageBucket: "fir-app-b0752.appspot.com",
            messagingSenderId: "486820420532",
            appId: "1:486820420532:web:5ab0a6b05bfcd0265eb0e1"));
  }
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCmam2EnFNEOF7a1HWfe1H26PBLLoNyNg4",
          appId: "1:486820420532:android:2d2598dbbdc4fa4f5eb0e1",
          messagingSenderId: "486820420532",
          projectId: "fir-app-b0752"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
