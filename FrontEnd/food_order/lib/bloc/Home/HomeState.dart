import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<CategoryVM> listCategory;
  final List<PromotionVM> listPromotion;
  HomeLoadedState(this.listCategory, this.listPromotion);
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
