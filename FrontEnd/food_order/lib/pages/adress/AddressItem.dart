import 'package:flutter/material.dart';
import 'package:food_delivery/models/AddressModel.dart';
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
                      child: Text(
                        adress.name,
                        style: AppTheme.titleStyle,
                      )),
                  Text(adress.addressString, style: AppTheme.subTitleStyle)
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
                await context.read<AddressModel>().delete(adress.id);
                await context.read<AddressModel>().fetchAll();
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
