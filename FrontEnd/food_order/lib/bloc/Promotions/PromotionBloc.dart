import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionEvent.dart';
import 'package:food_delivery/bloc/Promotions/PromotionState.dart';
import 'package:food_delivery/services/PromotionServices.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final PromotionServices _promotionServices = PromotionServices();

  PromotionBloc() : super(PromotionLoadingState());

  @override
  Stream<PromotionState> mapEventToState(PromotionEvent event) async* {
    if (event is PromotionStartedEvent) {
      yield* _mapStartedEventToState(state, event);
    }
  }

  Stream<PromotionState> _mapStartedEventToState(
      PromotionState currentState, PromotionStartedEvent event) async* {
    //stard Promotion
    yield PromotionLoadingState();
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield PromotionErrorState("Some thing went wrong!");
    }
  }

  Future<PromotionState> _fetchAll() async {
    var promotions = await _promotionServices.getAllValid();

    if (promotions.isSuccessed == false) {
      print(promotions.errorMessage);
      throw promotions.errorMessage!;
    }
    var listPromotions = promotions.payLoad!.items!;

    return PromotionLoadedState(listPromotions);
  }
}
