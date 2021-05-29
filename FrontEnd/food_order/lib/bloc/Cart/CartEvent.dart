import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';

@immutable
abstract class CartEvent {}

class CartStartedEvent extends CartEvent {}

class CartAddPromotionEvent extends CartEvent {
  final int promotionID;
  CartAddPromotionEvent(this.promotionID);
}

class CartRefreshdEvent extends CartEvent {}

class CartDeletedEvent extends CartEvent {
  final int cartID;
  CartDeletedEvent(this.cartID);
}

class CartCreatedEvent extends CartEvent {
  final int foodID;
  final int count;
  CartCreatedEvent(this.foodID, this.count);
}

class CartConfirmEvent extends CartEvent {
  final AddressVM addressVM;
  CartConfirmEvent(this.addressVM);
}

class CartSetAddressEvent extends CartEvent {
  final AddressVM addressVM;
  CartSetAddressEvent(this.addressVM);
}
