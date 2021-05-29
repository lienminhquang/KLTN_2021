import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Cart/CartState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'body.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        bottomNavigationBar: CheckoutCart());
  }
}

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    Key? key,
  }) : super(key: key);

  Widget _buildLoadedState(BuildContext context, CartLoadedState state) {
    // context.select<CartModel, List<CartVM>>((value) => value.items);
    double totalPrice = state.getTotalPrice();
    String? promotionCode;
    if (state.promotionVM != null) {
      promotionCode = state.promotionVM!.code;
      totalPrice = totalPrice * (100 - state.promotionVM!.percent) / 100;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      height: 174,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.orange,
                    size: 25,
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: promotionCode == null
                        ? Container()
                        : Text(promotionCode)),
                Spacer(),
                Text('Mã khuyến mãi'),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                      style: AppTheme.subTitleStyle,
                      text: 'Thành tiền:\n',
                      children: [
                        TextSpan(
                            text:
                                '\$${AppConfigs.AppNumberFormat.format(totalPrice)}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
                SizedBox(
                  width: 150,
                  child: MaterialButton(
                    height: 50,
                    minWidth: 100,
                    color: Colors.orange.shade400,
                    child: Text(
                      'Thanh toán',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (state.address == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content:
                                    Text("Vui lòng thêm địa chỉ giao hàng!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            });
                        return;
                      }
                      context
                          .read<CartBloc>()
                          .add(CartConfirmEvent(state.address!));
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       if (result == true)
                      //         return buildSuccessedOrderDialog(context);

                      //       return buildFailedOrderDialog(context);
                      //     });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, CartErrorState state) {
    return Container(
      child: Center(
        child: Text(state.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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

Widget buildSuccessedOrderDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Đặt hàng thành công!"),
    content: Text("Chúng tôi sẽ giao hàng đến bạn trong chốc lát."),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'Ok'),
        child: const Text('Ok'),
      ),
    ],
  );
}

Widget buildFailedOrderDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Đặt hàng không thành công!"),
    content: Text(
        "Vui lòng kiểm tra lại thông tin hoặc liên hệ chúng tôi để được hỗ trợ."),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'Ok'),
        child: const Text('Ok'),
      ),
    ],
  );
}

AppBar buildAppBar(BuildContext context) {
  //var count = context.select<CartModel, int>((value) => value.items.length);
  int count = 0;
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.blue.shade100,
    title: Column(
      children: [
        Text(
          'Giỏ hàng',
          style: TextStyle(color: Colors.black),
        ),
        Text(
          '$count sản phẩm',
          style: Theme.of(context).textTheme.caption,
        )
      ],
    ),
  );
}
