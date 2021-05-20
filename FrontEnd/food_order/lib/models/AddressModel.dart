import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/services/AddressServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class AddressModel extends ChangeNotifier {
  List<AddressVM> items = [];
  final AddressServices _addressServices = AddressServices();

  Future<void> fetchAll() async {
    //items.clear();
    final String userID = UserServices.getUserID();
    var result = await _addressServices.getAddressOfUser(userID);
    if (result.isSuccessed == true) {
      items = (result.payLoad!.items!);
    }
    notifyListeners();
  }

  Future<ApiResult<bool>> delete(int addressID) async {
    //final String userID = UserServices.getUserID();
    var result = await _addressServices.delete(addressID);

    notifyListeners();
    return result;
  }

  Future<ApiResult<AddressVM>> create(String name, String addressString) async {
    final String userID = UserServices.getUserID();
    var result = await _addressServices.create(name, addressString, userID);
    if (result.isSuccessed == false) {
      log(result.errorMessage!);
    }
    return result;
  }
}
