import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';

@immutable
abstract class CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {
  final String error;
  CartErrorState(this.error);
}

class CartLoadedState extends CartState {
  final AddressVM? address;
  final List<CartVM> listCartVM;
  CartLoadedState(this.address, this.listCartVM);

  double getTotalPrice() {
    // Todo: apply promotions
    double total = 0;
    for (var item in listCartVM) {
      total += item.quantity * item.foodVM.price;
    }
    return total;
  }
}
