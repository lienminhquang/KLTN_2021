import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline1: base.headline1!.copyWith(
      fontSize: 22.0,
      color: Colors.black,
    ));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xfff44336), // Header Colors
    buttonColor: Colors.redAccent, // primary colors button
    indicatorColor: Colors.redAccent, // line color when hover input
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        selectedItemColor: Colors.red, unselectedItemColor: Colors.grey),
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: Colors.red, //label color
      unselectedLabelColor: Colors.black, // unselected label of Tabbar color
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
}
