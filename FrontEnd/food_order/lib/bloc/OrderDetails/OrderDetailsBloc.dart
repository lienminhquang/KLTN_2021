import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsState.dart';
import 'package:food_delivery/services/OrderServices.dart';
import 'package:food_delivery/services/RatingServices.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/ratings/RatingCreateVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsLoadingState());
  final OrderServices _orderServices = OrderServices();
  final RatingServices _ratingServices = RatingServices();
  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvent event) async* {
    if (event is OrderDetailStartedEvent) {
      yield* _mapStartedEventToState(state, event);
    }
  }

  Stream<OrderDetailsState> _mapStartedEventToState(
      OrderDetailsState currentState, OrderDetailStartedEvent event) async* {
    yield OrderDetailsLoadingState();
    yield await _fetchAll(event.orderID);
  }

  Future<OrderDetailsState> _fetchAll(int orderID) async {
    var result = await _orderServices.getByID(orderID);
    if (result.isSuccessed == true) {
      return OrderDetailsLoadedState(result.payLoad!);
    }
    return OrderDetailsErrorState(result.errorMessage!);
  }

  Future<ApiResult<RatingVM>> createReview(
      RatingCreateVM ratingCreateVM) async {
    return await _ratingServices.create(ratingCreateVM);
  }
}
