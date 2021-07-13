import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'pages/FoodDescription.dart';
import 'pages/UserReview.dart';

class NamePrice extends StatelessWidget {
  final FoodDetailLoadedState _loadedState;
  NamePrice(this._loadedState);
  Widget _priceWidget() {
    FoodVM foodVM = _loadedState.foodVM;
    double discount = 0;
    if (_loadedState.foodVM.saleCampaignVM != null) {
      discount = _loadedState.foodVM.saleCampaignVM!.percent;
      final finalPrice = foodVM.price * (100 - discount) / 100;
      return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                  fontSize: 18.0,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
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

class DescriptionAndRating extends StatefulWidget {
  final FoodDetailLoadedState _loadedState;
  DescriptionAndRating(this._loadedState);
  @override
  _DescriptionAndRatingState createState() =>
      new _DescriptionAndRatingState(_loadedState);
}

class _DescriptionAndRatingState extends State<DescriptionAndRating>
    with SingleTickerProviderStateMixin {
  final FoodDetailLoadedState _loadedState;
  _DescriptionAndRatingState(this._loadedState);
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
        ),
      ),
      new Tab(
        child: new Text(
          "Đánh giá",
        ),
      ),
    ];
    _pages = [
      new FoodDescription(_loadedState.foodVM),
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
      color: Colors.white,
      child: Column(
        children: <Widget>[
          TabBar(
            isScrollable: true,
            controller: _controller,
            tabs: _tabs,
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

class FoodImage extends StatelessWidget {
  final FoodDetailLoadedState state;
  FoodImage({required this.state});
  @override
  Widget build(BuildContext context) {
    final foodVM = state.foodVM;
    final sale = state.foodVM.saleCampaignVM;
    int discount = 0;
    if (sale != null) {
      discount = sale.percent.toInt();
    }

    return Column(
      children: [
        Container(
          height: 280.0,
          child: new Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                  color: AppTheme.circleProgressIndicatorColor),
                          imageUrl:
                              AppConfigs.URL_Images + "/${foodVM.imagePath}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sale != null
                  ? Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.yellow,
                        ),
                        width: 70,
                        height: 30,
                        child: Center(
                          child: Text(
                            "-$discount%",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      bottom: 30,
                      right: 30,
                    )
                  : Container(),
              Positioned(
                left: 30,
                bottom: 30,
                child: Container(
                  width: 70.0,
                  height: 30.0,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(30.0)),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: new Offset(0.0, 10.0))
                      ]),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      new Text(foodVM.agvRating.toStringAsPrecision(2) +
                          " (${foodVM.totalRating})")
                    ],
                  ),
                ),
              ),
              //Appbar()
            ],
          ),
        ),
      ],
    );
  }
}
