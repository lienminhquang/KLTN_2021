import 'package:flutter/material.dart';

import 'Body.dart';

class PromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mã khuyến mãi'),
        ),
        body: Body());
  }
}
