import 'package:flutter/material.dart';
// import 'package:food_delivery/pages/MainPages.dart';
// import 'package:food_delivery/pages/Home.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';

import 'package:food_delivery/routers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      initialRoute: LoginPage.routeName,
    );
  }
}
