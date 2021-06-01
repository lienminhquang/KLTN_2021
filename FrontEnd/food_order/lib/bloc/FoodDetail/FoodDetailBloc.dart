import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailEvent.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/PromotionServices.dart';
import 'package:food_delivery/services/RatingServices.dart';
import 'package:food_delivery/services/UserServices.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc() : super(FoodDetailLoadingState());

  final FoodServices _foodServices = FoodServices();
  final _ratingServices = RatingServices();
  final _cartServices = CartServices();
  final _promotionServices = PromotionServices();

  Stream<FoodDetailState> _mapStatedEventToState(
      FoodDetailStartedEvent event, FoodDetailState currentState) async* {
    yield FoodDetailLoadingState();

    yield await _fetchAll(event.foodID, event.promotionID);
  }

  Stream<FoodDetailState> _mapCreateCartEventToState(
      FoodDetailCreateCartEvent event, FoodDetailState currentState) async* {
    if (state is FoodDetailLoadedState) {
      final String userID = UserServices.getUserID();
      var result =
          await _cartServices.editOrCreate(event.foodID, event.count, userID);
      if (result.isSuccessed == true) {
        yield await _fetchAll(event.foodID, event.promotionID);
      } else {
        yield FoodDetailErrorState(result.errorMessage!);
      }
    }
  }

  @override
  Stream<FoodDetailState> mapEventToState(FoodDetailEvent event) async* {
    if (event is FoodDetailStartedEvent) {
      yield* _mapStatedEventToState(event, state);
    } else if (event is FoodDetailCreateCartEvent) {
      yield* _mapCreateCartEventToState(event, state);
    } else {
      throw ("Unknown State");
    }
  }

  Future<FoodDetailState> _fetchAll(int foodID, int? promotionID) async {
    var foodDetail = await _foodServices.getFoodByID(foodID);
    if (foodDetail.isSuccessed == false) {
      return FoodDetailErrorState(foodDetail.errorMessage!);
    }
    var userRatings = await _ratingServices.getRatingsOfFood(foodID);
    if (userRatings.isSuccessed == false) {
      return FoodDetailErrorState(userRatings.errorMessage!);
    }
    var cartVM = await _cartServices.getByID(foodID, UserServices.getUserID());
    if (cartVM.isSuccessed == false) {
      return FoodDetailErrorState(cartVM.errorMessage!);
    }
    var promotionVM = promotionID == null
        ? null
        : await _promotionServices.getByID(promotionID);
    if (cartVM.isSuccessed == false) {
      return FoodDetailErrorState(promotionVM!.errorMessage!);
    }

    return FoodDetailLoadedState(
        foodDetail.payLoad!,
        userRatings.payLoad!.items!,
        cartVM.payLoad,
        promotionVM == null ? null : promotionVM.payLoad);
  }
}
