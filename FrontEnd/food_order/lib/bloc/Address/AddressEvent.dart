import 'package:flutter/cupertino.dart';
import 'package:food_delivery/view_models/Addresses/AddressCreateVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';

@immutable
abstract class AddressEvent {
  const AddressEvent();
}

class AddressStarted extends AddressEvent {}

class AddressDeleted extends AddressEvent {
  final int addressID;
  AddressDeleted(this.addressID);
}

class AddressCreated extends AddressEvent {
  final AddressCreateVM addressCreateVM;
  AddressCreated(this.addressCreateVM);
}

class AddressEdited extends AddressEvent {
  final AddressEditVM addressEditVM;
  AddressEdited(this.addressEditVM);
}
