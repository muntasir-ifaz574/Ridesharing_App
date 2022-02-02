import 'package:flutter/material.dart';
import 'package:uber/screens/home_screen.dart';
import 'package:uber/screens/login_screen.dart';
import 'package:uber/screens/registeration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber App',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
      ),
      home: RegisterationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
