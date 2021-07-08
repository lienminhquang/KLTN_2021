import 'package:flutter/material.dart';

import 'Body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.lightBlue,
    title: Column(
      children: [
        Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
