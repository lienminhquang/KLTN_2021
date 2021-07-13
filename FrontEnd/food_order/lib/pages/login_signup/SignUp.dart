//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/bloc/SignUp/SignUpBloc.dart';
import 'package:food_delivery/view_models/Users/RegisterRequest.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/signup";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(250.0, 50.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ))
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng điền tên";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Tên người dùng',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng điền số điện thoại";
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng điền mật khẩu";
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (a) {
                        if (a == null ||
                            a.isEmpty ||
                            a != _passwordController.text) {
                          return "Mật khẩu không khớp";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.redAccent,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                var registerRequest = RegisterRequest(
                                    "",
                                    _usernameController.text,
                                    _phoneNumberController.text,
                                    _passwordController.text);
                                var result = await context
                                    .read<SignUpBloc>()
                                    .signUp(registerRequest);
                                if (result.isSuccessed == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("User created!")));
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(result.errorMessage!)));
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'Đăng ký',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text('Quay lại',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
