import 'package:flutter/material.dart';
import 'package:food_delivery/services/OrderServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';

class OrderHistoryModel extends ChangeNotifier {
  List<OrderVM> allItems = [];
  List<OrderVM> incomingItems = [];
  List<OrderVM> completedItems = [];

  final OrderServices _orderServices = OrderServices();

  Future<void> fetchAll() async {
    //items.clear();
    incomingItems.clear();
    allItems.clear();
    completedItems.clear();
    final String userID = UserServices.getUserID();
    var result = await _orderServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      if (result.payLoad != null) allItems = (result.payLoad!);
    }
    for (var item in allItems) {
      if (item.orderStatusID != 4 && item.orderStatusID != 5) {
        incomingItems.add(item);
      } else {
        completedItems.add(item);
      }
    }
    notifyListeners();
  }
}
