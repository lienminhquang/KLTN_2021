import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Home/HomeState.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/services/PromotionServices.dart';
import 'package:food_delivery/services/SaleCampaignServices.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState());
  final CategoriesServices _categoriesServices = CategoriesServices();
  final PromotionServices _promotionServices = PromotionServices();
  final FoodServices _foodServices = FoodServices();
  final SaleCampaignServices _saleCampaignServices = SaleCampaignServices();

  Stream<HomeState> _mapStartedEventToState(HomeEvent event) async* {
    yield HomeLoadingState();
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield HomeErrorState("Error");
    }
  }

  Stream<HomeState> _mapRefreshEventToState(HomeRefeshEvent event) async* {
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield HomeErrorState("Error");
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStartedEvent) {
      yield* _mapStartedEventToState(event);
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

    var promotions = await _promotionServices.getAllValid();
    // todo: get all valid and enabled?
    if (result.isSuccessed == false) {
      print(result.errorMessage);
      throw result.errorMessage!;
    }
    if (promotions.isSuccessed == false) {
      print(promotions.errorMessage);
      throw promotions.errorMessage!;
    }
    var listPromotions = promotions.payLoad!.items!;
    for (var item in listPromotions) {
      item.foodVMs = (await _foodServices.getBestSellingFoods())
          .payLoad!
          .items!
          .take(10)
          .toList();
    }

    // Todo: must be get valid campaign instead
    var listSaleCampaign = await _saleCampaignServices.getAllValid();
    if (listSaleCampaign.isSuccessed == false) {
      print(listSaleCampaign.errorMessage);
      throw listSaleCampaign.errorMessage!;
    }

    return HomeLoadedState(result.payLoad!.items!, promotions.payLoad!.items!,
        listSaleCampaign.payLoad!.items!);
  }
}