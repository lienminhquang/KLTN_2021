import 'package:food_delivery/view_models/Categories/CategoryVM.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<CategoryVM> listCategory;
  HomeLoadedState(this.listCategory);
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
