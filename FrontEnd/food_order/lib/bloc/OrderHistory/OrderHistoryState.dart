import 'package:food_delivery/view_models/Orders/OrderVM.dart';

abstract class OrderHistoryState {}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistoryErrorState extends OrderHistoryState {
  final String error;
  OrderHistoryErrorState(this.error);
}

class OrderHistoryLoadedState extends OrderHistoryState {
  final List<OrderVM> incomingItems;
  final List<OrderVM> completedItems;
  OrderHistoryLoadedState(this.incomingItems, this.completedItems);
}
