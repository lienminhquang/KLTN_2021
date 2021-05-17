import 'package:flutter/material.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:provider/provider.dart';

class ProductDesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var foodVM = context.watch<FoodDetailModel>();
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: new Text(
          foodVM.foodVM.description,
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
