import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class CartModel extends ChangeNotifier {
  List<CartVM> items = [];
  final CartServices _cartServices = CartServices();

  Future<void> fetchAll() async {
    //items.clear();
    final String userID = UserServices.getUserID();
    var result = await _cartServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      items = (result.payLoad!.items!);
    }
    notifyListeners();
  }

  Future<bool> delete(int foodID) async {
    final String userID = UserServices.getUserID();
    var result = await _cartServices.delete(foodID, userID);
    if (result.isSuccessed == true) {
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<ApiResult<CartVM>> editOrCreate(int foodID, int quantity) async {
    final String userID = UserServices.getUserID();
    var result = await _cartServices.editOrCreate(foodID, quantity, userID);
    if (result.isSuccessed == false) {
      log(result.errorMessage!);
    }
    return result;
  }
}
