import 'package:flutter/material.dart';

import 'body.dart';

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
    backgroundColor: Colors.blue.shade100,
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
