import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

import 'Body.dart';

class PromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mã khuyến mãi'),
          backgroundColor: AppTheme.appBarBackground,
        ),
        body: Body());
  }
}
