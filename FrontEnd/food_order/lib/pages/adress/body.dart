import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Address/AddressBloc.dart';
import 'package:food_delivery/bloc/Address/AddressState.dart';
import 'package:food_delivery/pages/adress/AddAdressScreen.dart';
import 'Address.dart';
import 'AddressItem.dart';

class Body extends StatefulWidget {
  AddressScreenCallBack? addressScreenCallBack;
  Body(this.addressScreenCallBack);
  @override
  _BodyState createState() => _BodyState(addressScreenCallBack);
}

class _BodyState extends State<Body> {
  AddressScreenCallBack? addressScreenCallBack;
  _BodyState(this.addressScreenCallBack);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
      if (state is AddressLoadingState) {
        return const CircularProgressIndicator();
      }
      if (state is AddressLoadedState) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                itemCount: state.listAddress.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: AdressItem(
                    adress: state.listAddress[index],
                    addressScreenCallBack: addressScreenCallBack,
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return Text("Some thing went wrong!!");
    });
  }
}
