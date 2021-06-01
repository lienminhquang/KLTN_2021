import 'package:food_delivery/bloc/Address/AddressEvent.dart';
import 'package:food_delivery/bloc/Address/AddressState.dart';

import 'package:bloc/bloc.dart';
import 'package:food_delivery/services/AddressServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressCreateVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressLoadingState());

  final AddressServices _addressServices = AddressServices();

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is AddressStarted) {
      yield* _mapStartedEventToState();
    } else if (event is AddressDeleted) {
      yield* _mapDeletedEventToState(event, state);
    } else if (event is AddressCreated) {
      yield* _mapCreatedEventToState(event, state);
    } else if (event is AddressEdited) {
      yield* _mapEditedEventToState(event, state);
    }
  }

  Stream<AddressState> _mapDeletedEventToState(
      AddressDeleted event, AddressState state) async* {
    if (state is AddressLoadedState) {
      var result = await _addressServices.delete(event.addressID);
      if (result.isSuccessed == true) {
        yield await _fetchAll();
      } else {
        yield AddressErrorState(result.errorMessage!);
      }
    }
  }

  Stream<AddressState> _mapCreatedEventToState(
      AddressCreated event, AddressState state) async* {
    if (state is AddressLoadedState) {
      var result = await _addressServices.create(event.addressCreateVM);
      if (result.isSuccessed) {
        yield await _fetchAll();
      } else {
        yield AddressErrorState(result.errorMessage!);
      }
    }
  }

  Stream<AddressState> _mapEditedEventToState(
      AddressEdited event, AddressState state) async* {
    if (state is AddressLoadedState) {
      var result = await _addressServices.edit(event.addressEditVM);

      if (result.isSuccessed == true) {
        yield await _fetchAll();
      } else {
        yield AddressErrorState("Error");
      }
    }
  }

  Stream<AddressState> _mapStartedEventToState() async* {
    yield AddressLoadingState();
    yield await _fetchAll();
  }

  Future<AddressState> _fetchAll() async {
    final String userID = UserServices.getUserID();
    var result = await _addressServices.getAddressOfUser(userID);
    if (result.isSuccessed == true) {
      return AddressLoadedState(result.payLoad!.items!);
    }
    return AddressErrorState(result.errorMessage!);
  }

  Future<ApiResult<bool>> deleteAddress(int id) async {
    var result = await _addressServices.delete(id);
    return result;
  }

  Future<ApiResult<AddressVM>> editAddress(AddressEditVM addressEditVM) async {
    var result = await _addressServices.edit(addressEditVM);
    return result;
  }

  Future<ApiResult<AddressVM>> createAddress(
      AddressCreateVM addressCreateVM) async {
    addressCreateVM.appUserID = UserServices.getUserID();
    var result = await _addressServices.create(addressCreateVM);
    return result;
  }
}
