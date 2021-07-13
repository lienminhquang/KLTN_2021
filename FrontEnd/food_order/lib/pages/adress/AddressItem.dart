import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/Address/AddressBloc.dart';
import 'package:food_delivery/bloc/Address/AddressEvent.dart';
import 'package:food_delivery/pages/adress/EditAddressScreen.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:provider/provider.dart';

import 'Address.dart';

class AdressItem extends StatelessWidget {
  final AddressScreenCallBack? addressScreenCallBack;
  const AdressItem(
      {Key? key, required this.adress, required this.addressScreenCallBack})
      : super(key: key);
  final AddressVM adress;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(10),
      onPressed: () {
        if (addressScreenCallBack != null) {
          addressScreenCallBack!(adress, context);
        }
      },
      color: Color(0xFFFFFFFF),
      child: Row(
        children: [
          Container(
            child: Icon(
              Icons.location_pin,
              color: Colors.green,
            ),
            width: 50,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(adress.name,
                          style: Theme.of(context).textTheme.headline3)),
                  Text(adress.addressString,
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
          ),
          PopupMenuButton(
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.create_sharp,
                color: Colors.blue,
              ),
            ),
            onSelected: (index) async {
              if (index == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EditAdressScreen(adress);
                }));
              } else if (index == 1) {
                var result =
                    await context.read<AddressBloc>().deleteAddress(adress.id);
                if (result.isSuccessed) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Đã xóa địa chỉ")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.errorMessage!)));
                }
                context.read<AddressBloc>().add(AddressStarted());
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Delete'),
                )
              ];
            },
          ),
        ],
      ),
    );
  }
}
