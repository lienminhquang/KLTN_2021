import 'package:flutter/cupertino.dart';

abstract class FoodDetailEvent {}

class FoodDetailStartedEvent extends FoodDetailEvent {
  final int foodID;
  final int? promotionID;
  final int? saleID;
  FoodDetailStartedEvent({required this.foodID, this.saleID, this.promotionID});
}

// class FoodDetailCreateCartEvent extends FoodDetailEvent {
//   final int foodID;
//   final int count;
//   final int? promotionID;

//   final BuildContext context;
//   FoodDetailCreateCartEvent(
//       this.foodID, this.count, this.promotionID, this.context);
// }
