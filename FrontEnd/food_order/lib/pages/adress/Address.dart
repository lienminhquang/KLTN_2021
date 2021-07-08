import 'package:flutter/material.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';

import 'Body.dart';

typedef AddressScreenCallBack = void Function(
    AddressVM addressVM, BuildContext context);

class AddressScreen extends StatelessWidget {
  //static String routeName = "/adress";
  final AddressScreenCallBack? addressScreenCallBack;
  AddressScreen({required this.addressScreenCallBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () async {
                Navigator.of(context).pop();
              }),
          centerTitle: true,
          backgroundColor: Colors.blue.shade100,
          title: Text(
            'Địa chỉ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Body(addressScreenCallBack));
  }
}
