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
  final List<FoodVM> listFood;
  CategoryLoadedState(this.listFood, this.categoryVM);
}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState(this.error);
}
