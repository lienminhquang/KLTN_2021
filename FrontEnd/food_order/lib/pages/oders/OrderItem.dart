import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsBloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/OrderDetails/OrderDetails.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final OrderVM orderVM;
  OrderItem(this.orderVM);
  @override
  Widget build(BuildContext context) {
    String name = "";
    int foodCount = orderVM.orderDetailVMs.length;
    double price = 0;
    DateTime? datetime;
    if (orderVM.orderStatusID == 4 || orderVM.orderStatusID == 5) {
      datetime = orderVM.datePaid;
    } else {
      datetime = orderVM.createdDate;
    }
    for (var item in orderVM.orderDetailVMs) {
      name += item.foodVM!.name + ", ";
      price += item.price *
          item.amount *
          (item.salePercent == null ? 1 : (100 - item.salePercent!) / 100);
    }
    if (orderVM.promotionAmount != null) {
      price -= orderVM.promotionAmount!;
    }

    return GestureDetector(
      onTap: () {
        context
            .read<OrderDetailsBloc>()
            .add(OrderDetailStartedEvent(orderVM.id));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return OrderDetails();
        }));
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 2)
        ]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 115,
            color: Colors.grey[400],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Colors.green,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          orderVM.orderStatusVM.name,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                      Icon(
                        Icons.remove,
                        size: 15,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          datetime == null
                              ? ""
                              : DateFormat.MMMd().format(datetime),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  height: 15,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          "Giao đến: ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          orderVM.addressString,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 45,
                  color: Colors.white,
                  //color: Colors.grey.shade200,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  height: 25,
                  child: Row(
                    children: [
                      Text(
                        AppConfigs.toPrice(price),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " ($foodCount Món)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Center(
                      //     child: Icon(
                      //       Icons.more_horiz,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
