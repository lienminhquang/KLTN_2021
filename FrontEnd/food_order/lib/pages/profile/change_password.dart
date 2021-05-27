import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
      ),
      body: buildBody(context),
    );
  }
}

Widget buildBody(BuildContext context) {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  return SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Mật khẩu cũ',
              ),
              controller: _oldPasswordController,
              onChanged: (text) {},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mật khẩu mới'),
              controller: _newPasswordController,
              onChanged: (text) {},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
              controller: _confirmNewPasswordController,
              onChanged: (text) {},
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 30)),
            TextButton(
              child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 150,
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
