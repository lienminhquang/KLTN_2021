import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/CartModel.dart';
import 'package:food_delivery/pages/presentation/LightColor.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget _item(CartVM model) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
                padding: EdgeInsets.all(10.0),
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl:
                        AppConfigs.URL_Images + "/${model.foodVM.imagePath}",
                  ),
                )),
          ),
          Expanded(
              child: ListTile(
                  title: Text(
                    model.foodVM.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Text('\$ ',
                          style: TextStyle(
                            color: LightColor.red,
                            fontSize: 12,
                          )),
                      Text(model.foodVM.price.toString(),
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('x${model.quantity}',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  )))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var carts = context.select<CartModel, List<CartVM>>((value) => value.items);
    //context.watch<CartModel>().fetchAll("5d597675-8179-4575-7872-08d90b25fb90");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: ObjectKey(carts[index]),
            direction: DismissDirection.endToStart,
            background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  ],
                )),
            onDismissed: (direction) {
              setState(() {
                carts.removeAt(index);
              });
            },
            child: _item(carts[index]),
          ),
        ),
      ),
      // child: _cartItems()
    );
  }
}
