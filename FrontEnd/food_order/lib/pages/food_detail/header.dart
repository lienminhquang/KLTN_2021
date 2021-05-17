import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'clipper.dart';
import 'gredients.dart';
import 'customIcon.dart';
import 'package:provider/provider.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 0.35,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: new IconButton(
                icon: new Icon(
                  CustomIcons.menu,
                  color: Colors.black87,
                ),
                onPressed: () {
                  print("menu Clicked");
                },
                splashColor: Colors.black,
              )),
          new Expanded(
            child: new Container(),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: new Icon(
              Icons.shopping_cart,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var foodVM =
        context.select<FoodDetailModel, FoodVM>((value) => value.foodVM);

    return Container(
      margin: new EdgeInsets.only(top: 30.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              width: 140.0,
              height: 140.0,
              fit: BoxFit.fill,
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: AppConfigs.URL_Images + "/${foodVM.imagePath}",
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
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
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(foodVM.name,
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal)),
                        new Padding(
                          padding: const EdgeInsets.only(left: 28.0, top: 12.0),
                          child: new Text(foodVM.name,
                              style: new TextStyle(
                                color: Colors.black87.withOpacity(.3),
                              )),
                        ),
                      ]),
                  new Container(
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
                      Icons.share,
                      size: 25.0,
                      color: Colors.white,
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
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 280.0,
      child: new Stack(
        children: <Widget>[
          new ClipPath(
            clipper: new ArcClipper(),
            child: new Container(
              height: double.infinity,
              decoration: new BoxDecoration(gradient: bgGradient),
            ),
          ),
          new Align(
            alignment: FractionalOffset.center,
            heightFactor: 3.5,
            child: Content(),
          ),
          Appbar()
        ],
      ),
    );
  }
}
