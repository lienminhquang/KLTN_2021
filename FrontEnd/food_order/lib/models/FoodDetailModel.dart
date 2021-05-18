import 'package:flutter/material.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/RatingServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

class FoodDetailModel extends ChangeNotifier {
  final FoodServices _foodServices = FoodServices();
  final _ratingServices = RatingServices();
  final _cartServices = CartServices();

  CartVM? cartVM;
  FoodVM foodVM = FoodVM();
  List<RatingVM> ratingVMs = [];
  late int currentFoodID;

  FoodDetailModel();

  Future<bool> fetchFoodDetail(int id) async {
    currentFoodID = id;
    var result = await _foodServices.getFoodByID(id);
    if (result.isSuccessed == true) {
      foodVM = (result.payLoad!);
      await fetchCartVMIfExist();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> fetchCartVMIfExist() async {
    cartVM = null;
    var result =
        await _cartServices.getByID(currentFoodID, UserServices.getUserID());
    if (result.isSuccessed == true) {
      cartVM = result.payLoad;
    }
  }

  Future<void> fetchUserRatings() async {
    var result = await _ratingServices.getRatingsOfFood(currentFoodID);
    if (result.isSuccessed == true) {
      ratingVMs = (result.payLoad!.items)!;
    }
    notifyListeners();
  }
}
