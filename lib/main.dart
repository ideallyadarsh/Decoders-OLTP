import 'package:flutter/material.dart';
import 'package:oltp/screens/AdminPanel.dart';
import 'package:oltp/screens/Landing.dart';
import 'package:oltp/screens/widgets/AdminAddQuestions.dart';
import 'package:oltp/screens/widgets/AdminHome.dart';
import 'package:oltp/screens/widgets/AdminResults.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: "Decoders OLTP",
      home:LandingScreen(),
    );
  }
}

