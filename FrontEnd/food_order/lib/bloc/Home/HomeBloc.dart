import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Home/HomeState.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/PromotionServices.dart';
import 'package:food_delivery/services/SaleCampaignServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState());
  final CategoriesServices _categoriesServices = CategoriesServices();
  final PromotionServices _promotionServices = PromotionServices();
  final FoodServices _foodServices = FoodServices();
  final SaleCampaignServices _saleCampaignServices = SaleCampaignServices();

  Stream<HomeState> _mapStartedEventToState(
      HomeEvent event, HomeState currentState) async* {
    if ((currentState is HomeLoadedState) == false) {
      yield HomeLoadingState();
    }

    yield await _fetchAll();
  }

  Stream<HomeState> _mapRefreshEventToState(HomeRefeshEvent event) async* {
    yield await _fetchAll();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStartedEvent) {
      yield* _mapStartedEventToState(event, state);
    } else if (event is HomeRefeshEvent) {
      yield* _mapRefreshEventToState(event);
      // } else if (event is CartCreatedEvent) {
      //   yield* _mapCreatedEventToState(event, state);
      // } else if (event is CartConfirmEvent) {
      //   yield* _mapConfirmEventToState(event, state);
      // } else if (event is CartSetAddressEvent) {
      //   yield* _mapSetAddressEventToState(event, state);
    }
  }

  Future<HomeState> _fetchAll() async {
    //items.clear();
    var result = await _categoriesServices.getAllPaging();
    var userID = UserServices.getUserID();

    var rs = await _foodServices.getBestSellingFoods();

    if (rs.isSuccessed == false) {
      return HomeErrorState(rs.errorMessage!);
    }
    List<FoodVM> listBestSellingFood = rs.payLoad!.items!.take(10).toList();

    var promotionsValidForUser =
        await _promotionServices.getAllValidForUser(userID);
    // todo: get all valid and enabled?
    if (promotionsValidForUser.isSuccessed == false) {
      return HomeErrorState(result.errorMessage!);
    }
    if (promotionsValidForUser.isSuccessed == false) {
      print(promotionsValidForUser.errorMessage);
      return HomeErrorState(promotionsValidForUser.errorMessage!);
    }

    var promotionsValid = await _promotionServices.getAllValid(userID);
    // todo: get all valid and enabled?
    if (promotionsValid.isSuccessed == false) {
      return HomeErrorState(result.errorMessage!);
    }
    if (promotionsValid.isSuccessed == false) {
      print(promotionsValid.errorMessage);
      return HomeErrorState(promotionsValid.errorMessage!);
    }

    // Todo: must be get valid campaign instead
    var listSaleCampaign = await _saleCampaignServices.getAllValid();
    if (listSaleCampaign.isSuccessed == false) {
      print(listSaleCampaign.errorMessage);
      throw listSaleCampaign.errorMessage!;
    }

    return HomeLoadedState(
        result.payLoad!.items!,
        promotionsValidForUser.payLoad!.items!,
        promotionsValid.payLoad!.items!,
        listSaleCampaign.payLoad!.items!,
        listBestSellingFood);
  }
}
