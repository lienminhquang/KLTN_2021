import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/CartModel.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

import 'footer.dart';
import 'gredients.dart';
import 'package:provider/provider.dart';
import 'header.dart';

class FoodDetailArguments {
  bool displayCartBtn;
  FoodDetailArguments({this.displayCartBtn = true});
}

class FoodDetail extends StatefulWidget {
  static String routeName = "/food_detail";

  @override
  _FoodDetailState createState() => new _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  int count = 1;

  Widget bottomBtns(BuildContext context) {
    final price =
        context.select<FoodDetailModel, double>((value) => value.foodVM.price);
    final cartVM =
        context.select<FoodDetailModel, CartVM?>((value) => value.cartVM);
    if (cartVM != null) {
      count = cartVM.quantity;
    }

    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new InkWell(
              onTap: () async {
                var result = await context.read<CartModel>().editOrCreate(
                    context.read<FoodDetailModel>().currentFoodID, count);
                if (!result.isSuccessed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.errorMessage!)));
                } else {
                  // context.read<CartModel>().fetchAll();
                  // Navigator.pushReplacementNamed(
                  //     context, CartItemsPage.routeName);
                }
              },
              child: ClipRRect(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 50.0,
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: new Center(
                      child: new Text(
                        "\$ ${price * count}",
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
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (count > 1) count--;
                    if (cartVM != null) {
                      cartVM.quantity = count;
                    }
                  });
                },
                child: Icon(
                  Icons.remove,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          new Container(
            width: 40.0,
            height: 40.0,
            child: Center(
                child: Text("$count",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600))),
          ),
          ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    count++;
                    if (cartVM != null) {
                      cartVM.quantity = count;
                    }
                  });
                },
                child: Icon(
                  Icons.add,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var foodVM =
        context.select<FoodDetailModel, FoodVM>((value) => value.foodVM);
    log("rebuild bottomBtns");
    return new Scaffold(
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          new MHeader(
            foodVM: foodVM,
          ),
          FavnPrice(),
          //Divider(),
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
        height: 80,
        child: bottomBtns(context),
      ),
    );
  }
}
