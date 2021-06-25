import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';

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
  final PromotionVM? promotionVM;
  CartLoadedState(this.address, this.listCartVM, this.promotionVM);

  double getTotalPrice() {
    // Todo: apply promotions
    double total = 0;

    for (var item in listCartVM) {
      double discount = item.foodVM.saleCampaignVM == null
          ? 0
          : item.foodVM.saleCampaignVM!.percent;
      total += item.quantity * item.foodVM.price * (100 - discount) / 100;
    }
    return total;
  }

  double getPromotedAmount() {
    var totalPrice = getTotalPrice();
    if (promotionVM != null)
      return min(promotionVM!.max!, totalPrice * (promotionVM!.percent) / 100);
    else
      return 0;
  }

  int getTotalProduct() {
    // Todo: apply promotions
    int total = 0;

    for (var item in listCartVM) {
      total += item.quantity;
    }
    return total;
  }
}
