import 'package:flutter/material.dart';

import 'Body.dart';

class OderScreen extends StatelessWidget {
  static String routeName = "/oders";
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
          'Hóa đơn của bạn',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
