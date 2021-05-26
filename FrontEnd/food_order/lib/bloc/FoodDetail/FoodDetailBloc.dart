import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailEvent.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailState.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/RatingServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc() : super(FoodDetailLoadingState());

  final FoodServices _foodServices = FoodServices();
  final _ratingServices = RatingServices();
  final _cartServices = CartServices();

  Stream<FoodDetailState> _mapStatedEventToState(
      FoodDetailStartedEvent event, FoodDetailState currentState) async* {
    yield FoodDetailLoadingState();
    try {
      yield await _fetchAll(event.foodID);
    } catch (e) {
      print(e);
      yield FoodDetailErrorState("Error");
    }
  }

  Stream<FoodDetailState> _mapCreateCartEventToState(
      FoodDetailCreateCartEvent event, FoodDetailState currentState) async* {
    if (state is FoodDetailLoadedState)
      try {
        await _create(event.foodID, event.count);
        yield await _fetchAll(event.foodID);
      } catch (e) {}
  }

  Future<void> _create(int foodID, int quantity) async {
    final String userID = UserServices.getUserID();
    var result = await _cartServices.editOrCreate(foodID, quantity, userID);
    if (result.isSuccessed == false) {
      log(result.errorMessage!);
      throw result.errorMessage!;
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

  Future<FoodDetailState> _fetchAll(int id) async {
    try {
      var foodDetail = await _fetchFoodDetail(id);
      var userRatings = await _fetchUserRatings(id);
      var cartVM = await _fetchCartVMIfExist(id);
      return FoodDetailLoadedState(foodDetail, userRatings, cartVM);
    } catch (e) {
      return FoodDetailErrorState(e.toString());
    }
  }

  Future<FoodVM> _fetchFoodDetail(int id) async {
    var result = await _foodServices.getFoodByID(id);
    if (result.isSuccessed == true) {
      return (result.payLoad!);
    }
    throw result.errorMessage!;
  }

  Future<CartVM?> _fetchCartVMIfExist(int foodID) async {
    var result = await _cartServices.getByID(foodID, UserServices.getUserID());
    if (result.isSuccessed == true) {
      return result.payLoad;
    }
    return null;
  }

  Future<List<RatingVM>> _fetchUserRatings(int foodID) async {
    var result = await _ratingServices.getRatingsOfFood(foodID);
    if (result.isSuccessed == true) {
      return (result.payLoad!.items)!;
    }
    throw result.errorMessage!;
  }
}
