import 'dart:developer';

import 'package:food_delivery/bloc/Address/AddressEvent.dart';
import 'package:food_delivery/bloc/Address/AddressState.dart';

import 'package:bloc/bloc.dart';
import 'package:food_delivery/services/AddressServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressCreateVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';

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
      try {
        await _delete(event.addressID);
        yield await _fetchAll();
      } catch (e) {
        print(e);
        yield AddressErrorState("Error");
      }
    }
  }

  Stream<AddressState> _mapCreatedEventToState(
      AddressCreated event, AddressState state) async* {
    if (state is AddressLoadedState) {
      try {
        await _create(event.addressCreateVM);
        yield await _fetchAll();
      } catch (e) {
        print(e);
        yield AddressErrorState("Error");
      }
    }
  }

  Stream<AddressState> _mapEditedEventToState(
      AddressEdited event, AddressState state) async* {
    if (state is AddressLoadedState) {
      try {
        await _edit(event.addressEditVM);
        yield await _fetchAll();
      } catch (e) {
        print(e);
        yield AddressErrorState("Error");
      }
    }
  }

  Stream<AddressState> _mapStartedEventToState() async* {
    yield AddressLoadingState();
    try {
      yield await _fetchAll();
    } catch (e) {
      print(e);
      yield AddressErrorState("Error");
    }
  }

  Future<void> _delete(int addressID) async {
    var result = await _addressServices.delete(addressID);
    if (result.isSuccessed == false) {
      throw result.errorMessage!;
    }
  }

  Future<AddressState> _fetchAll() async {
    final String userID = UserServices.getUserID();
    var result = await _addressServices.getAddressOfUser(userID);
    if (result.isSuccessed == true) {
      return AddressLoadedState(result.payLoad!.items!);
    }
    return AddressErrorState(result.errorMessage!);
  }

  Future<void> _create(AddressCreateVM addressCreateVM) async {
    var result = await _addressServices.create(addressCreateVM);
    if (result.isSuccessed == false) {
      log(result.errorMessage!);
      throw result.errorMessage!;
    }
  }

  Future<void> _edit(AddressEditVM addressEditVM) async {
    var result = await _addressServices.edit(addressEditVM);
    if (result.isSuccessed == false) {
      log(result.errorMessage!);
      throw result.errorMessage!;
    }
  }
}
