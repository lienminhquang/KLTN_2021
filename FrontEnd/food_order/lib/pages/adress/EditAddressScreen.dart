import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/Address/AddressBloc.dart';
import 'package:food_delivery/bloc/Address/AddressEvent.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:provider/provider.dart';

class EditAdressScreen extends StatelessWidget {
  EditAdressScreen(this.addressVM);
  final AddressVM addressVM;
  final _adressController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sửa địa chỉ',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    _adressController.text = addressVM.addressString;
    _nameController.text = addressVM.name;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tên',
                ),
                controller: _nameController,
                onChanged: (text) {},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                controller: _adressController,
                onChanged: (text) {},
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 30)),
              TextButton(
                child: Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).buttonColor,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Sửa',
                      style: Theme.of(context).textTheme.button,
                    )),
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _adressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Name and address could not be null!")));
                    return;
                  }
                  final editVM = AddressEditVM();
                  editVM.id = addressVM.id;
                  editVM.appUserID = addressVM.appUserID;
                  editVM.name = _nameController.text;
                  editVM.addressString = _adressController.text;
                  var result =
                      await context.read<AddressBloc>().editAddress(editVM);
                  if (result.isSuccessed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Đã sửa địa chỉ")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result.errorMessage!)));
                  }
                  context.read<AddressBloc>().add(AddressStarted());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
