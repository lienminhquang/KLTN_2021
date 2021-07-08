import 'package:flutter/material.dart';

import 'LightColor.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: Colors.purple, backgroundColor: Colors.blue),
      ),
      backgroundColor: LightColor.background,
      primaryColor: Colors.lightBlue[600],
      cardTheme: CardTheme(color: LightColor.background),
      textTheme: TextTheme(headline4: TextStyle(color: LightColor.black)),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.lightGrey,
      primaryTextTheme:
          TextTheme(bodyText2: TextStyle(color: LightColor.titleTextColor)));

  //static TextStyle
  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 13);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static final TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body1 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle dateStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.green[900],
  );

  static final circleProgressIndicatorColor = Colors.grey[350];
}
