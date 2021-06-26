import 'package:flutter/material.dart';

import 'body.dart';

class PromotionScreen extends StatelessWidget {
  static String routeName = "/promotion";
  final double? totalPreis;
  PromotionScreen(this.totalPreis);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mã khuyến mãi'),
          backgroundColor: Colors.redAccent,
        ),
        body: Body(totalPreis));
  }
}
