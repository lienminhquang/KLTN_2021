import 'package:bloc/bloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Cart/CartState.dart';
import 'package:food_delivery/services/AddressServices.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/OrderServices.dart';
import 'package:food_delivery/services/PromotionServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Orders/OrderCreateVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState());

  final CartServices _cartServices = CartServices();
  final AddressServices _addressServices = AddressServices();
  final OrderServices _orderServices = OrderServices();
  final PromotionServices _promotionServices = PromotionServices();
  int? _promotionID;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartStartedEvent) {
      yield* _mapStartedEventToState(state);
    } else if (event is CartDeletedEvent) {
      yield* _mapDeletedEventToState(event, state);
      // } else if (event is CartCreatedEvent) {
      //   yield* _mapCreatedEventToState(event, state);
      // } else if (event is CartConfirmEvent) {
      //   yield* _mapConfirmEventToState(event, state);
    } else if (event is CartSetAddressEvent) {
      yield* _mapSetAddressEventToState(event, state);
    } else if (event is CartRefreshdEvent) {
      yield* _mapRefreshEventToState();
    } else if (event is CartAddPromotionEvent) {
      yield* _mapAddPromotionEventToState(event, state);
    } else if (event is CartRemovePromotionEvent) {
      _promotionID = null;
      yield await _fetchAll();
    }
  }

  Stream<CartState> _mapAddPromotionEventToState(
      CartAddPromotionEvent event, CartState state) async* {
    _promotionID = event.promotionID;
    if (state is CartLoadedState) {
      yield await _fetchAll();
    }
  }

  void _checkValidPromotionID() {}

  Stream<CartState> _mapDeletedEventToState(
      CartDeletedEvent event, CartState state) async* {
    if (state is CartLoadedState) {
      final String userID = UserServices.getUserID();
      var result = await _cartServices.delete(event.foodID, userID);

      if (result.isSuccessed) {
        yield await _fetchAll();
      } else {
        yield CartErrorState(result.errorMessage!);
      }
    }
  }

  Stream<CartState> _mapSetAddressEventToState(
      CartSetAddressEvent event, CartState state) async* {
    if (state is CartLoadedState) {
      var loadedState = await _fetchAll();
      yield CartLoadedState(
          event.addressVM, loadedState.listCartVM, loadedState.promotionVM);
    }
  }

  // Stream<CartState> _mapConfirmEventToState(
  //     CartConfirmEvent event, CartState state) async* {
  //   if (state is CartLoadedState) {
  //     var result = await confirm(event);
  //     if (result.isSuccessed == true) {
  //       yield await _fetchAll();
  //     } else {
  //       yield CartErrorState(result.errorMessage!);
  //     }
  //   }
  // }

  Stream<CartState> _mapStartedEventToState(CartState currentState) async* {
    if ((currentState is CartLoadedState) == false) {
      yield CartLoadingState();
    }

    yield await _fetchAll();
  }

  Stream<CartState> _mapRefreshEventToState() async* {
    yield await _fetchAll();
  }

  Future<CartLoadedState> _fetchAll() async {
    var listCartVM = await _fetchCartItems();
    var address = await _fetchAddress();
    var promotionVM = await _fetchPromotion(_promotionID);
    double total = 0;

    for (var item in listCartVM) {
      double discount = item.foodVM.saleCampaignVM == null
          ? 0
          : item.foodVM.saleCampaignVM!.percent;
      total += item.quantity * item.foodVM.price * (100 - discount) / 100;
    }

    if (promotionVM != null && promotionVM.minPrice! > total) {
      print(
          "Disable promotion due to invalid condition: ${promotionVM.minPrice!} <= ${total}");
      promotionVM = null;
      _promotionID = null;
    }

    return CartLoadedState(address, listCartVM, promotionVM);
  }

  Future<List<CartVM>> _fetchCartItems() async {
    //items.clear();
    final String userID = UserServices.getUserID();
    var result = await _cartServices.getAllByUserID(userID);
    if (result.isSuccessed == true) {
      return (result.payLoad!.items!);
    }

    throw result.errorMessage!;
  }

  Future<PromotionVM?> _fetchPromotion(int? promotionID) async {
    if (promotionID != null) {
      var promotion = await _promotionServices.getByID(promotionID);
      if (promotion.isSuccessed) {
        return promotion.payLoad;
      }
    }

    return null;
  }

  Future<AddressVM?> _fetchAddress() async {
    final String userID = UserServices.getUserID();
    var getAddressResult = await _addressServices.getAddressOfUser(userID);
    if (getAddressResult.isSuccessed) {
      if (getAddressResult.payLoad != null &&
          getAddressResult.payLoad!.items != null &&
          getAddressResult.payLoad!.items!.length > 0) {
        return getAddressResult.payLoad!.items![0];
      }
    }
    return null;
  }

  Future<ApiResult<OrderVM>> confirm(
      String addressString, String addressName, int? promotionID) async {
    final String userID = UserServices.getUserID();

    var result = await _orderServices.create(OrderCreateVM.explicit(
        appUserID: userID,
        isPaid: false,
        orderStatusID: 2,
        addressString: addressString,
        addressName: addressName,
        promotionID: promotionID));
    return result;
  }
}
