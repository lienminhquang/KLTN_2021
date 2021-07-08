import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

import 'Body.dart';

class Search extends StatelessWidget {
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
    backgroundColor: AppTheme.appBarBackground,
    title: Column(
      children: [
        Text(
          'Tìm kiếm',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
