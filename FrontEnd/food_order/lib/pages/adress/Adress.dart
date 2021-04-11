import 'package:flutter/material.dart';

import 'body.dart';

class AdressScreen extends StatelessWidget {
  static String routeName = "/adress";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Địa chỉ')), body: Body());
  }
}
