import 'package:firebase_firestore/landing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.orange),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade700,
            foregroundColor: Colors.orange),
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontFamily: 'Helvetica-B'),
          bodyText1: TextStyle(
            fontFamily: 'Helvetica-B',
          ),
          subtitle1: TextStyle(fontFamily: 'Helvetica-B'),
          subtitle2: TextStyle(fontFamily: 'Helvetica-B'),
          headline1: TextStyle(fontFamily: 'Helvetica-B'),
          headline2: TextStyle(fontFamily: 'Helvetica-B'),
          headline3: TextStyle(fontFamily: 'Helvetica-B'),
          headline4: TextStyle(fontFamily: 'Helvetica-B'),
          headline5: TextStyle(fontFamily: 'Helvetica-B'),
          headline6: TextStyle(fontFamily: 'Helvetica-B'),
        ),
      ),
      home: const Landing(),
    );
  }
}
