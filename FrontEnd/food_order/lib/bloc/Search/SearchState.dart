import 'package:equatable/equatable.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEmptyState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<FoodVM> listFood;
  final List<CategoryVM> listCategory;
  SearchSuccessState(this.listFood, this.listCategory);

  @override
  List<Object?> get props => [listFood];
}

class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
