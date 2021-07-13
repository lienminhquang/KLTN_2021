import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

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
    backgroundColor: Theme.of(context).primaryColor,
    title: Column(
      children: [
        Text(
          'Thông tin cá nhân',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    ),
  );
}
