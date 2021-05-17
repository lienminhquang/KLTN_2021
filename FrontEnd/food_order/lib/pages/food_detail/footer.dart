import 'package:flutter/material.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'pages/specification.dart';
import 'pages/productDesc.dart';
import 'pages/userReviews.dart';
import 'package:provider/provider.dart';

class FavnPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodVM foodVM =
        context.select<FoodDetailModel, FoodVM>((value) => value.foodVM);
    return new Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 25.0, bottom: 12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              new Text("Add to favorive")
            ],
          ),
          Column(
            children: [
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "\$",
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ),
                  new Text(
                    foodVM.price.toString(),
                    style: new TextStyle(fontSize: 35.0),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "\$",
                      style: new TextStyle(fontSize: 10.0),
                    ),
                  ),
                  new Text(
                    foodVM.price.toString(),
                    style: new TextStyle(
                        fontSize: 15.0,
                        decoration: TextDecoration.lineThrough,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Mfooter extends StatefulWidget {
  @override
  _MfooterState createState() => new _MfooterState();
}

class _MfooterState extends State<Mfooter> with SingleTickerProviderStateMixin {
  late List<Tab> _tabs;
  late List<Widget> _pages;
  static late TabController _controller;
  @override
  void initState() {
    super.initState();

    _tabs = [
      new Tab(
        child: new Text(
          "Product Description",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      new Tab(
        child: new Text(
          "specification",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      new Tab(
        child: new Text(
          "User reviews",
          style: new TextStyle(color: Colors.black),
        ),
      ),
    ];
    _pages = [new ProductDesc(), new Specification(), new UserReview()];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: _tabs,
          indicatorColor: Colors.white,
        ),
        new Divider(
          height: 1.0,
        ),
        new SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: new TabBarView(
            controller: _controller,
            children: _pages,
          ),
        ),
      ],
    );
  }
}
