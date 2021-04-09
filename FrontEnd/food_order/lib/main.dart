import 'package:flutter/material.dart';
// import 'package:food_delivery/pages/MainPages.dart';
// import 'package:food_delivery/pages/Home.dart';
import 'package:food_delivery/pages/Login.dart';
import 'package:food_delivery/pages/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
