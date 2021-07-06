import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

@immutable
abstract class CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  //final List<CategoryVM> listCategory;
  //CategoryLoadedState(this.listCategory);

  final CategoryVM categoryVM;
  final List<FoodVM> allFood;
  final List<FoodVM> bestSelling;
  final List<FoodVM> promoting;
  CategoryLoadedState(
      this.allFood, this.bestSelling, this.promoting, this.categoryVM);
}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState(this.error);
}
