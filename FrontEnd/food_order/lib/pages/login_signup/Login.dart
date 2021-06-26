import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/app.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Login/LoginBloc.dart';
import 'package:food_delivery/bloc/Login/LoginState.dart';
import 'package:food_delivery/pages/login_signup/ResetPassword.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/login_signup/SignUp.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
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

  @override
  void dispose() {
    _usenameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

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
            context.read<HomeBloc>().add(HomeStartedEvent());
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
                            return 'Vui lòng nhập số điện thoại!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Số điện thoại',
                            prefix: Icon(Icons.phone, color: Colors.redAccent),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
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
                            prefix: Icon(Icons.lock, color: Colors.redAccent),
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  Icons.visibility,
                                )),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        obscureText: isHiddenPassword,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),

                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: Colors.red,
                          color: Colors.redAccent,
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
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ResetPasswordPage();
                            }));
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SignupPage();
                  }));
                },
                child: Text('Đăng ký',
                    style: TextStyle(
                      color: Colors.redAccent,
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
    return WillPopScope(
      onWillPop: () async {
        var rs = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Bạn có muốn thoát ứng dụng?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Có")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Không"))
                ],
              );
            });
        return rs == true;
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoadingState) {
          return CircularProgressIndicator();
        } else if (state is LoginLoadedState) {
          return _buildLoaedState(context, state);
        } else if (state is LoginErrorState) {
          return _buildErrorState(context, state);
        }
        throw "Unknow state";
      }),
    );
  }
}
