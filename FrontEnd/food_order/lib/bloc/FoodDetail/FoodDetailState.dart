import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

@immutable
abstract class FoodDetailState {}

class FoodDetailLoadingState extends FoodDetailState {}

class FoodDetailLoadedState extends FoodDetailState {
  final List<RatingVM> userRatingList;
  final FoodVM foodVM;
  final CartVM? cartVM;
  FoodDetailLoadedState(this.foodVM, this.userRatingList, this.cartVM);
}

class FoodDetailErrorState extends FoodDetailState {
  final String error;
  FoodDetailErrorState(this.error);
}
