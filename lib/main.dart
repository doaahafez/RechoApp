import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recho/routs/Splashscreen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC61vP_kf1z-78EdK5CO-rK0cGXTvq2TsU",
        projectId: "recho-de013",
        messagingSenderId: "744711300993",
        appId: "1:744711300993:android:9c9b6cb451735278162a80",
      ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Splashscreen(),

      );
  }
}


