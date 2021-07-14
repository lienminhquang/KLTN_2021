import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Cart/CartState.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionEvent.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';
import 'package:food_delivery/pages/promotion/body.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({Key? key, required this.state}) : super(key: key);
  final CartLoadedState state;

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
                                        builder: (context) => promotionDetail(
                                            state.promotionVM!));
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
                    child: Text(
                      'Mã khuyến mãi',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
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
                      style: Theme.of(context).textTheme.bodyText1,
                      text: 'Thành tiền:\n',
                      children: [
                        TextSpan(
                            text: '${AppConfigs.toPrice(finalPrice)}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'))
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
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).buttonColor),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok',
                                        style:
                                            Theme.of(context).textTheme.button),
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
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).buttonColor),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Ok',
                                      style: Theme.of(context).textTheme.button,
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

  @override
  Widget build(BuildContext context) {
    return _buildLoadedState(context, state);
  }
}

Widget buildSuccessedOrderDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Đặt hàng thành công!"),
    content: Text("Chúng tôi sẽ giao hàng đến bạn trong chốc lát."),
    actions: [
      TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).buttonColor),
        onPressed: () => Navigator.pop(context, 'Ok'),
        child: Text(
          'Ok',
          style: Theme.of(context).textTheme.button,
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
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).buttonColor),
        onPressed: () => Navigator.pop(context, 'Ok'),
        child: Text('Ok', style: Theme.of(context).textTheme.button),
      ),
    ],
  );
}
