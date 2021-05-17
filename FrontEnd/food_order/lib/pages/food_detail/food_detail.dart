import 'package:flutter/material.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

import 'footer.dart';
import 'gredients.dart';
import 'package:provider/provider.dart';
import 'header.dart';

class FoodDetail extends StatefulWidget {
  static String routeName = "/food_detail";

  @override
  _FoodDetailState createState() => new _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var bottomBtns = new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new InkWell(
              onTap: () {},
              child: new ClipRRect(
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                child: new Container(
                  decoration: new BoxDecoration(
                      gradient: btnGradient,
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                            offset: new Offset(0.0, 10.0))
                      ]),
                  height: 60.0,
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: new Center(
                      child: new Text(
                        "Buy Now",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  gradient: btnGradient,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.black12,
                        offset: new Offset(0.0, 10.0))
                  ]),
              child: new Icon(
                Icons.add_shopping_cart,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );

    return new Scaffold(
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          new MHeader(),
          FavnPrice(),
          Divider(),
          NotificationListener<OverscrollNotification>(
              onNotification: (OverscrollNotification value) {
                if (value.overscroll < 0 &&
                    _scrollController.offset + value.overscroll <= 0) {
                  if (_scrollController.offset != 0)
                    _scrollController.jumpTo(0);
                  return true;
                }
                if (_scrollController.offset + value.overscroll >=
                    _scrollController.position.maxScrollExtent) {
                  if (_scrollController.offset !=
                      _scrollController.position.maxScrollExtent)
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  return true;
                }
                _scrollController
                    .jumpTo(_scrollController.offset + value.overscroll);
                return true;
              },
              child: new Mfooter()),
        ],
      ),
      bottomNavigationBar: Container(
        child: bottomBtns,
      ),
    );
  }
}
