import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_p/main_page.dart';
import 'package:mini_p/sample.dart';
import 'package:mini_p/todo.dart/work.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCPDqdqIqjhiIERKbZjdAXwvO2kvGbFSpA",
        appId: "1:914396095719:android:51016b8da90b36b298ee42",
        messagingSenderId: "914396095719",
        projectId: "minip-5619c",

    )

  ): await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

