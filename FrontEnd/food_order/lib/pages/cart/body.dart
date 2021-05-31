import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Cart/CartState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/pages/presentation/LightColor.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget _priceWidget(CartVM cartVM) {
    if (cartVM.foodVM.saleCampaignVM != null) {
      double discount = cartVM.foodVM.saleCampaignVM!.percent;
      return Row(
        children: <Widget>[
          Text('\$ ',
              style: TextStyle(
                color: LightColor.red,
                fontSize: 12,
              )),
          Text(
              AppConfigs.AppNumberFormat.format(cartVM.foodVM.price *
                      cartVM.quantity *
                      (100 - discount) /
                      100) +
                  "  ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(
              AppConfigs.AppNumberFormat.format(
                  cartVM.foodVM.price * cartVM.quantity),
              style: TextStyle(
                  fontSize: 14, decoration: TextDecoration.lineThrough)),
        ],
      );
    }
    return Row(
      children: <Widget>[
        Text('\$ ',
            style: TextStyle(
              color: LightColor.red,
              fontSize: 12,
            )),
        Text(
            AppConfigs.AppNumberFormat.format(
                cartVM.foodVM.price * cartVM.quantity),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _item(CartVM model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // context
        //     .read<FoodDetailBloc>()
        //     .add(FoodDetailStartedEvent(model.foodID));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FoodDetail(foodID: model.foodID, promotionID: null);
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
                    subtitle: _priceWidget(model),
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

  Widget totalSession(BuildContext context, CartLoadedState state) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        children: [
          Text(
            "Tổng: ",
            style: TextStyle(color: Colors.grey),
          ),
          Text(AppConfigs.AppNumberFormat.format(state.getTotalPrice()))
        ],
      ),
    );
  }

  Widget addressSession(BuildContext context, AddressVM? addressVM) {
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
                              addressVM == null
                                  ? "Không tìm thấy địa chỉ nào!"
                                  : addressVM.addressString,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    //await context.read<AddressBloc>().fetchAll();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddressScreen(
                        addressScreenCallBack:
                            (AddressVM addressVM, BuildContext context) async {
                          context
                              .read<CartBloc>()
                              .add(CartSetAddressEvent(addressVM));

                          Navigator.of(context).pop();
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

  _buildLoadedState(BuildContext context, CartLoadedState state) {
    var carts = state.listCartVM;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CartBloc>().add(CartRefreshdEvent());
      },
      child: ListView.builder(
        itemCount: carts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return addressSession(context, state.address);
          } else if (index == carts.length + 1) {
            return totalSession(context, state);
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
              context
                  .read<CartBloc>()
                  .add(CartDeletedEvent(carts[index - 1].foodID));
            },
            child: _item(carts[index - 1], context),
          );
        },
      ),
    );
  }

  _buildErrorState(BuildContext context, CartErrorState state) {
    return Container(
      child: Center(
        child: Text(state.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      //return _buildErrorState(context, CartErrorState("test error"));
      if (state is CartLoadingState) {
        return CircularProgressIndicator();
      }
      if (state is CartLoadedState) {
        return _buildLoadedState(context, state);
      }
      if (state is CartErrorState) {
        return _buildErrorState(context, state);
      }
      throw "Unknow state";
    });
  }
}
