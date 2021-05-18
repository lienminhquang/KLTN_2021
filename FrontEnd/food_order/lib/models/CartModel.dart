import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';

class CartModel extends ChangeNotifier {
  List<CartVM> items = [];
  final CartServices _cartServices = CartServices();

  Future<void> fetchAll(String userID) async {
    //items.clear();
    var result = await _cartServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      items = (result.payLoad!.items!);
    }
    notifyListeners();
  }

  Future<void> addToCart(String userID, int foodID, int quantity) async {
    var result = await _cartServices.addToCart(userID, foodID, quantity);
    if (result.isSuccessed == true) {}
    notifyListeners();
  }
}
