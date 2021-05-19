import 'package:flutter/material.dart';

import 'body.dart';

class OderScreen extends StatelessWidget {
  static String routeName = "/oders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Body(),
    );
  }
}
