import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

import 'Body.dart';

class Search extends StatelessWidget {
  final int? categoryID;
  Search(this.categoryID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBar(context),
      body: SearchBody(categoryID),
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
          'Tìm kiếm',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    ),
  );
}
