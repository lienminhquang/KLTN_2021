import 'package:flutter/material.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/RatingServices.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

class FoodDetailModel extends ChangeNotifier {
  final FoodServices _foodServices = FoodServices();
  final _ratingServices = RatingServices();

  FoodVM foodVM = FoodVM();
  List<RatingVM> ratingVMs = [];
  late int currentFoodID;

  FoodDetailModel() {}

  Future<void> fetchFoodDetail(int id) async {
    currentFoodID = id;
    var result = await _foodServices.getFoodByID(id);
    if (result.isSuccessed == true) {
      foodVM = (result.payLoad!);
    }
    notifyListeners();
  }

  Future<void> fetchUserRatings() async {
    var result = await _ratingServices.getRatingsOfFood(currentFoodID);
    if (result.isSuccessed == true) {
      ratingVMs = (result.payLoad!.items)!;
    }
    notifyListeners();
  }
}
