import 'package:flutter/material.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class ProductDesc extends StatelessWidget {
  final FoodVM _foodVM;
  ProductDesc(this._foodVM);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: new Text(
          _foodVM.description,
          style: new TextStyle(
              fontFamily: "OpenSans",
              color: Colors.black,
              fontSize: 13.0,
              fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
