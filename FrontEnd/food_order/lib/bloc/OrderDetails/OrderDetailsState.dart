import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/view_models/Orders/OrderDetailVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';

abstract class OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsLoadedState extends OrderDetailsState {
  final OrderVM orderVM;
  OrderDetailsLoadedState(this.orderVM);
}

class OrderDetailsErrorState extends OrderDetailsState {
  final String error;
  OrderDetailsErrorState(this.error);
}
