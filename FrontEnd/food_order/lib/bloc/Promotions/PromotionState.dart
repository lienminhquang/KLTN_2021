import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';

abstract class PromotionState {}

class PromotionLoadingState extends PromotionState {}

class PromotionErrorState extends PromotionState {
  final String error;
  PromotionErrorState(this.error);
}

class PromotionLoadedState extends PromotionState {
  final List<PromotionVM> listPromotionVMs;
  PromotionLoadedState(this.listPromotionVMs);
}
//dữ liệu màn hình ở 1 thời điểm
