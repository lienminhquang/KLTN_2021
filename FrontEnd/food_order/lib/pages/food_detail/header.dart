import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailBloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';
import 'package:provider/provider.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 0.35,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new Container(),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var foodVM =
        (context.read<FoodDetailBloc>().state as FoodDetailLoadedState).foodVM;

    return Container(
      margin: new EdgeInsets.only(top: 30.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140.0,
              height: 140.0,
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 80,
                  ),
                  new Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        //gradient: btnGradient,
                        color: Colors.white,
                        shape: BoxShape.circle,
                        //border: Border.all(color: Colors.black),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12,
                              offset: new Offset(0.0, 10.0))
                        ]),
                    child: new Icon(
                      Icons.favorite_sharp,
                      size: 25.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

class MHeader extends StatelessWidget {
  final FoodDetailLoadedState state;
  MHeader({required this.state});
  @override
  Widget build(BuildContext context) {
    final foodVM = state.foodVM;
    final promotion = state.promotionVM;
    int discount = 0;
    if (promotion != null) {
      discount = promotion.percent.toInt();
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
                              CircularProgressIndicator(),
                          imageUrl:
                              AppConfigs.URL_Images + "/${foodVM.imagePath}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              promotion != null
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
              Appbar()
            ],
          ),
        ),
      ],
    );
  }
}
