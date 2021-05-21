import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/AddressServices.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class CartModel extends ChangeNotifier {
  List<CartVM> items = [];
  AddressVM? address;
  final CartServices _cartServices = CartServices();
  final AddressServices _addressServices = AddressServices();

  double getTotalPrice() {
    // Todo: apply promotions
    double total = 0;
    for (var item in items) {
      total += item.quantity * item.foodVM.price;
    }
    return total;
  }

  Future<void> fetchAll() async {
    //items.clear();
    final String userID = UserServices.getUserID();
    var result = await _cartServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      items = (result.payLoad!.items!);
    }
    var getAddressResult = await _addressServices.getAddressOfUser(userID);
    if (getAddressResult.isSuccessed) {
      if (getAddressResult.payLoad != null &&
          getAddressResult.payLoad!.items != null &&
          getAddressResult.payLoad!.items!.length > 0) {
        address = getAddressResult.payLoad!.items![0];
      } else {
        address = null;
      }
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
