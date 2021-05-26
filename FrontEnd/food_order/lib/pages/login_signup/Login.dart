import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/app.dart';
import 'package:food_delivery/bloc/Login/LoginBloc.dart';
import 'package:food_delivery/bloc/Login/LoginState.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/login_signup/SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserServices _userServices = new UserServices();

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
        var loginResult = _userServices.login(_loginVM);
        loginResult.then((value) {
          if (value.isSuccessed == false) {
            log(value.errorMessage!.toString());

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.errorMessage!)));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return MotherBoard();
              },
            ));
          }
        }, onError: (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        });
      }
      _isLogin = false;
    }
  }

  Widget _buildLoaedState(BuildContext context, LoginLoadedState state) {
    if (state.map != null) {
      _usenameTextController.text = state.map!["username"]! as String;
      _passwordTextController.text = state.map!["password"]! as String;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                  child: Text(
                    'Xin',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                  child: Text(
                    'Chào',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(225.0, 175.0, 0.0, 0.0),
                    child: Text(
                      '!',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                        labelText: 'Username',
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
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.routeName);
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline),
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: ImageIcon(
                                  AssetImage('images/iconfacebook.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text('Đăng nhập bằng Facebook',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
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

  Widget _buildErrorState(BuildContext context, LoginErrorState state) {
    return Container(
        child: Center(
      child: Text(
        state.error,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoadingState) {
        return CircularProgressIndicator();
      } else if (state is LoginLoadedState) {
        return _buildLoaedState(context, state);
      } else if (state is LoginErrorState) {
        return _buildErrorState(context, state);
      }
      throw "Unknow state";
    });
  }
}
