import 'package:flutter/material.dart';

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
    backgroundColor: Colors.redAccent,
    title: Column(
      children: [
        Text(
          'Tìm kiếm',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
