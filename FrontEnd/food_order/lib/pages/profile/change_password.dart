import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/SignUp/SignUpBloc.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:provider/provider.dart';

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
  final _formKey = GlobalKey<FormState>();

  return SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mật khẩu cũ',
                ),
                controller: _oldPasswordController,
                onChanged: (text) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mật khẩu hiện tại";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mật khẩu mới'),
                controller: _newPasswordController,
                onChanged: (text) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mật khẩu mới";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
                controller: _confirmNewPasswordController,
                onChanged: (text) {},
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != _newPasswordController.text) {
                    return "Mật khẩu nhập lại không khớp";
                  }
                  return null;
                },
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result = await context
                        .read<SignUpBloc>()
                        .changePassword(_oldPasswordController.text,
                            _newPasswordController.text);
                    if (result.isSuccessed == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Thay đổi mật khẩu thành công!")));
                      UserServices userServices = UserServices();
                      await userServices.logout();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.errorMessage!)));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
