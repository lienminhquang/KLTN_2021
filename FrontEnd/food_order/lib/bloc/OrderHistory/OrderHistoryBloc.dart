import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryEvent.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryState.dart';
import 'package:food_delivery/services/OrderServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryLoadingState());
  final OrderServices _orderServices = OrderServices();
  @override
  Stream<OrderHistoryState> mapEventToState(OrderHistoryEvent event) async* {
    if (event is OrderHistoryStartedEvent) {
      yield* _mapStartedEventToState(event);
    }
    if (event is OrderHistoryRefreshEvent) {
      yield* _mapRefeshEventToState(event);
    }
  }

  Stream<OrderHistoryState> _mapStartedEventToState(
      OrderHistoryEvent event) async* {
    yield OrderHistoryLoadingState();
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield OrderHistoryErrorState("Error!");
    }
  }

  Stream<OrderHistoryState> _mapRefeshEventToState(
      OrderHistoryEvent event) async* {
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield OrderHistoryErrorState("Error!");
    }
  }

  Future<OrderHistoryState> _fetchAll() async {
    List<OrderVM> allItems = [];
    List<OrderVM> incomming = [];
    List<OrderVM> completed = [];
    final String userID = UserServices.getUserID();
    var result = await _orderServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      if (result.payLoad != null) allItems = (result.payLoad!);
      for (var item in allItems) {
        if (item.orderStatusID != 4 && item.orderStatusID != 5) {
          incomming.add(item);
        } else {
          completed.add(item);
        }
      }
      return OrderHistoryLoadedState(incomming, completed);
    }
    return OrderHistoryErrorState(result.errorMessage!);
  }
}
