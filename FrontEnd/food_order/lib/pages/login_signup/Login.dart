import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/AppModel.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/login_signup/SignUp.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserServices _userServices = new UserServices();
  bool isHiddenPassword = true;
  final _usenameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;

  Future<void> login(BuildContext context) async {
    if (!_isLogin) {
      _isLogin = true;
      if (_formKey.currentState!.validate()) {
        LoginVM _loginVM = LoginVM(
            _usenameTextController.text, _passwordTextController.text, false);
        var loginResult = await context.read<AppModel>().login(_loginVM);
        if (loginResult.isSuccessed == false) {
          // show error
          log(loginResult.errorMessage!);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(loginResult.errorMessage!)));
        } else {
          var category = context.read<CategoryModel>();
          category.fetchAll();
        }
      }
      _isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: SizedBox(
                height: 155,
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: _userServices.getUserAccountFromCache(),
            builder: (BuildContext context,
                AsyncSnapshot<ApiResult<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isSuccessed == true) {
                  _usenameTextController.text =
                      snapshot.data!.payLoad!["username"]! as String;
                  _passwordTextController.text =
                      snapshot.data!.payLoad!["password"]! as String;
                }
              }
              return Container(
                padding: EdgeInsets.only(top: 0.0, left: 40.0, right: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _usenameTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Số điện thoại',
                            prefix: Icon(Icons.phone),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      ), //
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Mật khẩu ',
                            prefix: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility)),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                        obscureText: isHiddenPassword,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CartScreen.routeName);
                          },
                          child: Center(
                            child: Text(
                              'Quên mật khẩu',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              login(context);
                            },
                            child: Center(
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Container(
                      //   height: 40.0,
                      //   color: Colors.transparent,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //           color: Colors.black,
                      //           style: BorderStyle.solid,
                      //           width: 1.0),
                      //       color: Colors.transparent,
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Center(
                      //             child: ImageIcon(
                      //                 AssetImage('images/iconfacebook.png'))),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Center(
                      //           child: Text('Đăng nhập bằng Facebook',
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   fontFamily: 'Montserrat')),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bạn chưa có tài khoản ?',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SignupPage.routeName);
                },
                child: Text('Đăng ký',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  void _togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}
