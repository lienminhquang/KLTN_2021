import 'package:flutter/material.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
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
          left: 20.0, right: 20.0, top: 10.0, bottom: 12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Text(
              foodVM.name,
              style: new TextStyle(
                  fontSize: 25.0,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              "\$" + foodVM.price.toString(),
              style: new TextStyle(fontSize: 20.0),
            ),
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
          "Food details",
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
    _pages = [new ProductDesc(), new UserReview()];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          TabBar(
            isScrollable: true,
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.black26,
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
      ),
    );
  }
}
