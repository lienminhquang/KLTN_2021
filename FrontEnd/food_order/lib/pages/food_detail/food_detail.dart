import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailBloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailEvent.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';

import 'footer.dart';
import 'package:provider/provider.dart';
import 'header.dart';

class FoodDetailArguments {
  bool displayCartBtn;
  FoodDetailArguments({this.displayCartBtn = true});
}

class FoodDetail extends StatefulWidget {
  final int foodID;
  final int? promotionID;
  FoodDetail({required this.foodID, this.promotionID});

  static String routeName = "/food_detail";

  @override
  _FoodDetailState createState() =>
      new _FoodDetailState(foodID: foodID, promotionID: promotionID);
}

class _FoodDetailState extends State<FoodDetail> with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  int count = 1;

  final int foodID;
  final int? promotionID;

  _FoodDetailState({required this.foodID, this.promotionID});

  @override
  void initState() {
    context
        .read<FoodDetailBloc>()
        .add(FoodDetailStartedEvent(foodID: foodID, promotionID: promotionID));

    super.initState();
  }

  Widget bottomBtns(BuildContext context, FoodDetailLoadedState state) {
    final price = state.foodVM.price;
    final cartVM = state.cartVM;
    final promotion = state.promotionVM;
    double discount = 0;
    if (cartVM != null) {
      count = cartVM.quantity;
    }
    if (state.foodVM.saleCampaignVM != null) {
      discount = state.foodVM.saleCampaignVM!.percent;
    }
    final totalPrice = (price * count) * (100 - discount) / 100;

    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new InkWell(
              onTap: () async {
                // if (promotion != null) {
                //   context
                //       .read<CartBloc>()
                //       .add(CartAddPromotionEvent(promotionID!));
                // }

                var result = await context
                    .read<FoodDetailBloc>()
                    .createCart(state.foodVM.id, count);
                if (result.isSuccessed == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.errorMessage!)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Đã thêm vào giỏ hàng!")));
                  Navigator.of(context).pop();
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
                        "${AppConfigs.toPrice(totalPrice)}",
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

  Widget _buildLoadedState(BuildContext context, FoodDetailLoadedState state) {
    return Scaffold(
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          new MHeader(
            state: state,
          ),
          FavnPrice(state),
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
              child: new Mfooter(state)),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: bottomBtns(context, state),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, FoodDetailErrorState state) {
    return Scaffold(body: Container(child: Center(child: Text(state.error))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodDetailBloc, FoodDetailState>(
        builder: (context, state) {
      if (state is FoodDetailLoadingState) {
        print("FoodDetailLoadingState");
        return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()));
      }
      if (state is FoodDetailLoadedState) {
        return _buildLoadedState(context, state);
      }
      if (state is FoodDetailErrorState) {
        return _buildErrorState(context, state);
      }
      throw "Unknown state!";
    });
  }
}
