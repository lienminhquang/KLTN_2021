import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/AddressModel.dart';
import 'package:food_delivery/models/CartModel.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/pages/adress/AddAdressScreen.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/pages/presentation/LightColor.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final NumberFormat _numberFormat = NumberFormat();
  AddressVM? _addressVM;

  Widget _item(CartVM model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<FoodDetailModel>().fetchAll(model.foodID);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FoodDetail();
        }));
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          new BoxShadow(
            blurRadius: 3.0,
            color: Colors.black12,
            //offset: new Offset(0.0, 10.0))
          )
        ]),
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
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
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
                        Text(
                            AppConfigs.AppNumberFormat.format(
                                model.foodVM.price * model.quantity),
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
      ),
    );
  }

  Widget addressSession(BuildContext context) {
    return Container(
      //height: 150,
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Địa điểm nhận hàng",
                              style: AppTheme.subTitleStyle,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _addressVM == null
                                  ? "Không tìm thấy địa chỉ nào!"
                                  : _addressVM!.addressString,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await context.read<AddressModel>().fetchAll();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddressScreen(
                        addressScreenCallBack:
                            (AddressVM addressVM, BuildContext context) async {
                          //_addressVM = addressVM;
                          context.read<CartModel>().setAddress(addressVM);
                          //await context.read<CartModel>().fetchAll();
                          Navigator.of(context).pop();
                          //setState(() {});
                        },
                      );
                    }));
                  },
                  child: Container(
                      width: 80,
                      child: Text(
                        "Thay đổi",
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      )),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 16,
            //indent: 20,
            //endIndent: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Align(
              child: Text(
                "Đơn hàng",
                style: AppTheme.subTitleStyle,
              ),
              alignment: Alignment.centerLeft,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var carts = context.watch<CartModel>().items;
    _addressVM = context.read<CartModel>().address;

    return ListView.builder(
      itemCount: carts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return addressSession(context);
        }

        return Dismissible(
          key: ObjectKey(carts[index - 1]),
          direction: DismissDirection.endToStart,
          background: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
          onDismissed: (direction) async {
            var cartModel = context.read<CartModel>();
            if (await cartModel.delete(carts[index - 1].foodID)) {
              cartModel.fetchCartItems();
            }
          },
          child: _item(carts[index - 1], context),
        );
      },
    );
  }
}
