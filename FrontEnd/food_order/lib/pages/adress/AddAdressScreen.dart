import 'package:flutter/material.dart';

class AddAdressScreen extends StatefulWidget {
  static String routeName = "/addadress";

  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm địa chỉ'),
      ),
      body: BodyAdressScreen(),
    );
  }
}

class BodyAdressScreen extends StatefulWidget {
  @override
  _BodyAdressScreenState createState() => _BodyAdressScreenState();
}

class _BodyAdressScreenState extends State<BodyAdressScreen> {
  final _adressController = TextEditingController();
  final _nameController = TextEditingController();
  final _sdtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      'Thêm địa chỉ',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () async {
                  // if (_nameController.text.isEmpty ||
                  //     _adressController.text.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: Text("Name and address could not be null!")));
                  //   return;
                  // }
                  // var rs = await context
                  //     .read<AddressModel>()
                  //     .create(_nameController.text, _adressController.text);
                  // await context.read<AddressModel>().fetchAll();
                  // if (rs.isSuccessed == false) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text("Failed to create address!")));
                  // } else {
                  //   Navigator.pop(context);
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
