import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery/configs/DevHttpsOveride.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/pages/home/Home.dart';
// import 'package:food_delivery/pages/MainPages.dart';
// import 'package:food_delivery/pages/Home.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';

import 'package:food_delivery/routers.dart';
import 'package:provider/provider.dart';

void main() {
  //acept bad certificate request
  HttpOverrides.global = new DevHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryModel()),
        ChangeNotifierProvider(create: (context) => FoodDetailModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        initialRoute: LoginPage.routeName,
      ),
    );
  }
}
