import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/view_models/Orders/OrderDetailVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';

abstract class OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsLoadedState extends OrderDetailsState {
  final OrderVM orderVM;
  late double tempPrice;
  late double finalPrice;
  late double promotedAmount;
  OrderDetailsLoadedState(this.orderVM) {
    tempPrice = 0;
    for (var i = 0; i < orderVM.orderDetailVMs.length; i++) {
      var detail = orderVM.orderDetailVMs[i];
      double discount = detail.salePercent != null ? detail.salePercent! : 0;
      tempPrice += detail.price * detail.amount * (100 - discount) / 100;
    }
    promotedAmount =
        orderVM.promotionAmount == null ? 0 : orderVM.promotionAmount!;
    finalPrice = tempPrice - promotedAmount;
  }
}

class OrderDetailsErrorState extends OrderDetailsState {
  final String error;
  OrderDetailsErrorState(this.error);
}
