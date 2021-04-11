import 'package:flutter/material.dart';

import 'body.dart';

class PromotionScreen extends StatelessWidget {
  static String routeName = "/promotion";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Mã khuyến mãi')), body: Body());
  }
}
