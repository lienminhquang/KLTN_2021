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
        title: Text('Them dia chi'),
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
                decoration: InputDecoration(labelText: 'Địa chỉ mới'),
                controller: _adressController,
                onChanged: (text) {},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tên'),
                controller: _nameController,
                onChanged: (text) {},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                controller: _sdtController,
                onChanged: (text) {},
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 30)),
              ButtonTheme(
                height: 60,
                minWidth: 200,
                child: FlatButton(
                  child: Text('Thêm địa chỉ'),
                  textColor: Colors.white,
                  color: Colors.orange,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
