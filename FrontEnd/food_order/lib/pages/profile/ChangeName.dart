import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/Profile/ProfileBloc.dart';
import 'package:food_delivery/bloc/Profile/ProfileEvent.dart';
import 'package:food_delivery/bloc/SignUp/SignUpBloc.dart';
import 'package:provider/provider.dart';

class ChangeNameScreen extends StatelessWidget {
  final String oldName;
  ChangeNameScreen(this.oldName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đổi tên',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: buildBody(context, oldName),
    );
  }
}

Widget buildBody(BuildContext context, String oldName) {
  final _nameController = TextEditingController();
  _nameController.text = oldName;

  final _formKey = GlobalKey<FormState>();

  return SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nhập tên của bạn',
                ),
                controller: _nameController,
                onChanged: (text) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập tên";
                  }
                  return null;
                },
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 30)),
              TextButton(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).buttonColor,
                    ),
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Xác nhận',
                      style: Theme.of(context).textTheme.button,
                    )),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result = await context.read<SignUpBloc>().changeName(
                          _nameController.text,
                        );
                    if (result.isSuccessed == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Đổi tên thành công!")));
                      context.read<ProfileBloc>().add(ProfileRefreshEvent());
                      Navigator.of(context).pop();
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
