import 'package:flutter/material.dart';

import 'testdata_adress.dart';

class AdressItem extends StatelessWidget {
  const AdressItem({
    Key? key,
    required this.adress,
  }) : super(key: key);
  final Adress adress;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(10),
      onPressed: () {},
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.home_outlined,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Nhà'),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Flexible(
                child: Text(
                  adress.adress,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Text(adress.name),
              SizedBox(
                width: 15,
              ),
              Text(adress.sdt)
            ],
          ),
        ],
      ),
    );
  }
}
