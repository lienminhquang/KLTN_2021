import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

import 'body.dart';

class NoficationScreen extends StatelessWidget {
  static String routeName = "/nofication";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: AppTheme.appBarBackground,
      ),
      body: Body(),
    );
  }
}
