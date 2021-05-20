import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';

class AdressItem extends StatelessWidget {
  const AdressItem({
    Key? key,
    required this.adress,
  }) : super(key: key);
  final AddressVM adress;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(10),
      onPressed: () {},
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
          Align(
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
        ],
      ),
    );
  }
}
