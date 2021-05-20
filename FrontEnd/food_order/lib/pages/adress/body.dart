import 'package:flutter/material.dart';
import 'package:food_delivery/models/AddressModel.dart';
import 'package:food_delivery/pages/adress/Add_AdressScreen.dart';
import 'package:food_delivery/pages/adress/testdata_adress.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:provider/provider.dart';
import 'adress_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addresses =
        context.select<AddressModel, List<AddressVM>>((value) => value.items);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddAdressScreen();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
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
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: AdressItem(adress: addresses[index]),
            ),
          ),
        ),
      ],
    );
  }
}
