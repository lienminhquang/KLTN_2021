import 'package:flutter/material.dart';
import 'package:food_delivery/pages/adress/Add_AdressScreen.dart';
import 'package:food_delivery/pages/adress/testdata_adress.dart';

import 'adress_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            children: [
              FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Navigator.pushNamed(context, AddAdressScreen.routeName);
                },
                color: Color(0xFFFFFFFF),
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text('Thêm địa chỉ mới')),
                    Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: demoAdress.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: AdressItem(adress: demoAdress[index]),
            ),
          ),
        ),
      ],
    );
  }
}
