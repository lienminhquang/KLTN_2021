import 'package:flutter/material.dart';
import 'package:food_delivery/models/AddressModel.dart';
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
        title: Text('Sửa địa chỉ'),
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
                decoration: InputDecoration(labelText: 'Tên'),
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
                    height: 40,
                    width: 150,
                    child: Text(
                      'Sửa',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _adressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Name and address could not be null!")));
                    return;
                  }
                  var rs = await context.read<AddressModel>().edit(
                      addressVM.id,
                      addressVM.appUserID,
                      _nameController.text,
                      _adressController.text);
                  await context.read<AddressModel>().fetchAll();
                  if (rs.isSuccessed == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to edit address!")));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
