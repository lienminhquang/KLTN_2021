import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';

@immutable
abstract class AddressState {}

class AddressLoadingState extends AddressState {}

class AddressLoadedState extends AddressState {
  final List<AddressVM> listAddress;
  AddressLoadedState(this.listAddress);
}

class AddressErrorState extends AddressState {
  final String errorMessage;
  AddressErrorState(this.errorMessage);
}
