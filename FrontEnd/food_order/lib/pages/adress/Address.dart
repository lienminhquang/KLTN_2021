import 'package:flutter/material.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';

import 'body.dart';

typedef AddressScreenCallBack = void Function(
    AddressVM addressVM, BuildContext context);

class AddressScreen extends StatelessWidget {
  static String routeName = "/adress";
  final AddressScreenCallBack? addressScreenCallBack;
  AddressScreen({required this.addressScreenCallBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Địa chỉ')),
        body: Body(addressScreenCallBack));
  }
}
