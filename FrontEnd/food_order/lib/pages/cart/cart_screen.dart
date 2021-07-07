import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Cart/CartState.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionEvent.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';
import 'body.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  void showInvalidPromotionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Mã khuyến mãi không hợp lệ, vui lòng nhấn vào mã khuyến mãi để kiểm tra lại điều kiện."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }

  Widget _buildLoadedState(BuildContext context, CartLoadedState state) {
    // context.select<CartModel, List<CartVM>>((value) => value.items);
    double totalPrice = state.getTotalPrice();
    double finalPrice = totalPrice;
    String? promotionCode;
    if (state.promotionVM != null) {
      promotionCode = state.promotionVM!.code;
      finalPrice = totalPrice - state.getPromotedAmount();
    }

    Widget icon = Icon(
      Icons.confirmation_num_outlined,
      color: Colors.orange,
      size: 25,
    );

    if (state.promotionVM != null &&
        state.promotionVM!.minPrice! > totalPrice) {
      icon = Container(
        width: 25,
        height: 25,
        child: IconButton(
            iconSize: 25,
            padding: EdgeInsets.zero,
            onPressed: () {
              showInvalidPromotionDialog(context);
            },
            icon: Icon(
              Icons.error_outline_outlined,
              color: Colors.orange,
              //size: 25,
            )),
      );
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
                  child: icon,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: promotionCode == null
                        ? Container()
                        : Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                          backgroundColor: Colors.transparent,
                                          insetPadding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white),
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 50, 20, 20),
                                                child: Column(children: [
                                                  Text(state.promotionVM!.name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                  SizedBox(height: 20),
                                                  Text(
                                                      state.promotionVM!
                                                          .desciption
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(
                                                      "Áp dụng cho đơn hàng từ: ${AppConfigs.toPrice(state.promotionVM!.minPrice!)}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(
                                                      "Tối đa: ${AppConfigs.toPrice(state.promotionVM!.max!)}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade700)),
                                                ]),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                  child: Text(promotionCode)),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(CartRemovePromotionEvent());
                                },
                                icon: Icon(Icons.cancel),
                                iconSize: 15,
                              )
                            ],
                          )),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      context
                          .read<PromotionBloc>()
                          .add(PromotionStartedEvent());
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PromotionScreen();
                      }));
                    },
                    child: Text('Mã khuyến mãi')),
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
                            text: '${AppConfigs.toPrice(finalPrice)}',
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
                      if (state.listCartVM.length <= 0) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content: Text("Giỏ hàng đang rỗng!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            });
                        return;
                      }
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
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            });
                        return;
                      }
                      if (state.promotionVM != null &&
                          state.promotionVM!.minPrice! > totalPrice) {
                        showInvalidPromotionDialog(context);
                        return;
                      }
                      var result = await context.read<CartBloc>().confirm(
                          state.address!.addressString,
                          state.address!.name,
                          state.promotionVM == null
                              ? null
                              : state.promotionVM!.id);

                      showDialog(
                          context: context,
                          builder: (context) {
                            if (result.isSuccessed == true)
                              return buildSuccessedOrderDialog(context);
                            else
                              return buildFailedOrderDialog(
                                  context, result.errorMessage);
                          });
                      context.read<CartBloc>().add(CartRefreshdEvent());

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
        child: const Text(
          'Ok',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

Widget buildFailedOrderDialog(BuildContext context, String? error) {
  return AlertDialog(
    title: Text("Đặt hàng không thành công!"),
    content: Text(error == null
        ? ""
        : error +
            "\nVui lòng kiểm tra lại thông tin hoặc liên hệ chúng tôi để được hỗ trợ."),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'Ok'),
        child: const Text('Ok', style: TextStyle(color: Colors.white)),
      ),
    ],
  );
}

AppBar buildAppBar(BuildContext context) {
  //var count = context.select<CartModel, int>((value) => value.items.length);
  int count = 0;
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.lightBlue,
    title: Column(
      children: [
        Text(
          'Giỏ hàng',
          style: TextStyle(color: Colors.black),
        ),
        // Text(
        //   '$count sản phẩm',
        //   style: Theme.of(context).textTheme.caption,
        // )
      ],
    ),
  );
}
