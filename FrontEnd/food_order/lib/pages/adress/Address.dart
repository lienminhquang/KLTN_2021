import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Địa chỉ',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Body(addressScreenCallBack));
  }
}
