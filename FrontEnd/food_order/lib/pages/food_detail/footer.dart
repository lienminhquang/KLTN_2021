import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'pages/productDesc.dart';
import 'pages/userReviews.dart';

class FavnPrice extends StatelessWidget {
  final FoodDetailLoadedState _loadedState;
  FavnPrice(this._loadedState);
  Widget _priceWidget() {
    FoodVM foodVM = _loadedState.foodVM;
    double discount = 0;
    if (_loadedState.foodVM.saleCampaignVM != null) {
      discount = _loadedState.foodVM.saleCampaignVM!.percent;
      final finalPrice = foodVM.price * (100 - discount) / 100;
      return Column(children: [
        Text(
          AppConfigs.toPrice(finalPrice),
          style: new TextStyle(fontSize: 20.0),
        ),
        Text(
          AppConfigs.toPrice(foodVM.price),
          style: new TextStyle(
              fontSize: 13.0,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey),
        ),
      ]);
    }
    return Column(children: [
      Text(
        AppConfigs.toPrice(foodVM.price),
        style: new TextStyle(fontSize: 20.0),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    FoodVM foodVM = _loadedState.foodVM;

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
            child: _priceWidget(),
          )
        ],
      ),
    );
  }
}

class Mfooter extends StatefulWidget {
  final FoodDetailLoadedState _loadedState;
  Mfooter(this._loadedState);
  @override
  _MfooterState createState() => new _MfooterState(_loadedState);
}

class _MfooterState extends State<Mfooter> with SingleTickerProviderStateMixin {
  final FoodDetailLoadedState _loadedState;
  _MfooterState(this._loadedState);
  late List<Tab> _tabs;
  late List<Widget> _pages;
  static late TabController _controller;
  @override
  void initState() {
    super.initState();

    _tabs = [
      new Tab(
        child: new Text(
          "Giới thiệu",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      new Tab(
        child: new Text(
          "Đánh giá",
          style: new TextStyle(color: Colors.black),
        ),
      ),
    ];
    _pages = [
      new ProductDesc(_loadedState.foodVM),
      new UserReview(_loadedState.userRatingList)
    ];
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
