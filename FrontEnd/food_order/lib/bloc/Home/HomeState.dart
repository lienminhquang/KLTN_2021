import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';
import 'package:food_delivery/view_models/SaleCampaigns/SaleCampaignVM.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<CategoryVM> listCategory;
  final List<PromotionVM> listPromotion;
  final List<SaleCampaignVM> listSaleCampaign;
  final List<FoodVM> listBestSellingFood;
  HomeLoadedState(this.listCategory, this.listPromotion, this.listSaleCampaign,
      this.listBestSellingFood);
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
