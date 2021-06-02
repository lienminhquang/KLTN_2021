import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsBloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/commons/start_ratings.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/pages/presentation/LightColor.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Orders/OrderDetailVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:food_delivery/view_models/ratings/RatingCreateVM.dart';

class OrderDetailsBody extends StatelessWidget {
  var _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) {
      if (state is OrderDetailsLoadingState) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is OrderDetailsLoadedState) {
        return _buildLoadedState(context, state);
      }
      if (state is OrderDetailsErrorState) {
        return Container(
          child: Center(child: Text(state.error)),
        );
      }
      throw "Unknow state";
    });
  }

  Widget _buildLoadedState(
      BuildContext context, OrderDetailsLoadedState state) {
    return Container(
      child: Column(
        children: [
          addressSession(
              context, state.orderVM.addressName, state.orderVM.addressString),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _item(state.orderVM.orderDetailVMs[index], state.orderVM,
                    context);
              },
              itemCount: state.orderVM.orderDetailVMs.length,
            ),
          )
        ],
      ),
    );
  }

  Widget addressSession(
      BuildContext context, String addressName, String addressString) {
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
                              addressString,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      )
                    ],
                  ),
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

  Widget _comment(BuildContext context, OrderDetailVM model) {
    if (model.ratingVM == null) {
      //_commentController.text = model.ratingVM!.comment;
      return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: TextField(
                  controller: _commentController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 13, height: 1),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Bạn thấy món này như thế nào?',
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  if (_commentController.text.isNotEmpty) {
                    double _rating = 0;
                    var result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text("OK")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("Cancel"))
                            ],
                            title: Center(
                                child: Text(
                              "Bạn chấm món này mấy điểm? :)",
                              textAlign: TextAlign.center,
                            )),
                            content: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: RatingButton((rating) {
                                _rating = rating;
                              }, _rating),
                            ),
                          );
                        });
                    if (result == true) {
                      var rs = await context
                          .read<OrderDetailsBloc>()
                          .createReview(RatingCreateVM(
                              model.orderID,
                              model.foodID,
                              _rating.toInt(),
                              _commentController.text));
                      if (rs.isSuccessed == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(rs.errorMessage!)));
                      }
                      context
                          .read<OrderDetailsBloc>()
                          .add(OrderDetailStartedEvent(model.orderID));
                    }
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.blue,
                ))
          ],
        ),
      );
    }
    return Container();
  }

  Widget _item(OrderDetailVM model, OrderVM orderVM, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        new BoxShadow(
          blurRadius: 3.0,
          color: Colors.black12,
          //offset: new Offset(0.0, 10.0))
        )
      ]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FoodDetail(foodID: model.foodID, promotionID: null);
              }));
            },
            child: Container(
              height: 70,
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
                            imageUrl: AppConfigs.URL_Images +
                                "/${model.foodVM!.imagePath}",
                          ),
                        )),
                  ),
                  Expanded(
                      child: ListTile(
                          title: Text(
                            model.foodVM!.name,
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
                            child: Text('x${model.amount}',
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                          )))
                ],
              ),
            ),
          ),
          orderVM.orderStatusID == OrderStatus.DaNhanHang
              ? _comment(context, model)
              : Container(),
        ],
      ),
    );
  }

  Widget _priceWidget(OrderDetailVM cartVM) {
    if (cartVM.saleCampaignID != null) {
      double discount = cartVM.salePercent!;
      return Row(
        children: <Widget>[
          Text('\$ ',
              style: TextStyle(
                color: LightColor.red,
                fontSize: 12,
              )),
          Text(
              AppConfigs.AppNumberFormat.format(
                      cartVM.price * cartVM.amount * (100 - discount) / 100) +
                  "  ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(AppConfigs.AppNumberFormat.format(cartVM.price * cartVM.amount),
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
                cartVM.foodVM!.price * cartVM.amount),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class RatingButton extends StatefulWidget {
  final RatingChangeCallback _ratingChangeCallback;
  final double _startStar;
  RatingButton(this._ratingChangeCallback, this._startStar);
  @override
  _RatingButtonState createState() =>
      _RatingButtonState(_ratingChangeCallback, _startStar);
}

class _RatingButtonState extends State<RatingButton> {
  RatingChangeCallback _ratingChangeCallback;

  _RatingButtonState(this._ratingChangeCallback, this.start);
  double start;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: StarRating(
        iconSize: 30,
        rating: start,
        onRatingChanged: (rating) {
          start = rating;
          _ratingChangeCallback(rating);
          setState(() {});
        },
      ),
    );
  }
}
