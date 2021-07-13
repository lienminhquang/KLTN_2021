import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline1: base.headline1!.copyWith(
            // font for header
            fontSize: 22.0,
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600),
        bodyText1: base.bodyText1!.copyWith(
            // font for bodytext
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'Montserrat'),
        headline2: base.headline2!.copyWith(
            // font for text link
            fontSize: 12,
            color: Colors.blueAccent,
            fontFamily: 'Montserrat'),
        button: base.button!.copyWith(
            // font for text of button
            fontSize: 15,
            color: Colors.white,
            fontFamily: 'Montserrat'),
        headline3: base.headline3!.copyWith(
            // font for text of bodytext
            fontSize: 15,
            color: Colors.black,
            fontFamily: 'Montserrat'));
    // headline4: base.headline4!.copyWith(
    //     // font for text of button
    //     fontSize: 12,
    //     color: Colors.green,
    //     fontFamily: 'Montserrat'));
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
      labelColor: Colors.red,
      labelStyle: TextStyle(fontFamily: 'Montserrat'), //label color
      unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
      unselectedLabelColor: Colors.black, // unselected label of Tabbar color
      indicator: ShapeDecoration(
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.redAccent), // underline color of TabBaritem
        ),
      ),
    ),
    iconTheme: IconThemeData(
      // icon colors
      color: Colors.black,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      labelStyle:
          TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontSize: 12),
    ),
    textSelectionTheme:
        base.textSelectionTheme.copyWith(cursorColor: Colors.redAccent),
  );
}
