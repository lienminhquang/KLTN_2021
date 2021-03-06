import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/app.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Login/LoginBloc.dart';
import 'package:food_delivery/bloc/Login/LoginState.dart';
import 'package:food_delivery/pages/home/AppLoadingScreen.dart';
import 'package:food_delivery/pages/login_signup/ResetPassword.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/pages/cart/CartScreen.dart';
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
            _usenameTextController.text = "";
            _passwordTextController.text = "";
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
          Container(
            padding: EdgeInsets.only(top: 0.0, left: 40.0, right: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usenameTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui l??ng nh???p s??? ??i???n tho???i!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'S??? ??i???n tho???i',
                      prefix: Icon(Icons.phone,
                          color: Theme.of(context).buttonColor),
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ), //
                  SizedBox(
                    height: 15.0,
                  ),

                  TextFormField(
                    controller: _passwordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui l??ng nh???p m???t kh???u';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'M???t kh???u ',
                      prefix: Icon(Icons.lock,
                          color: Theme.of(context).buttonColor),
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            Icons.visibility,
                          )),
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
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
                      color: Colors.blue,
                      elevation: 7.0,
                      child: FlatButton(
                        color: Theme.of(context).buttonColor,
                        onPressed: () {
                          login(context);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => AppLoadingScreen()));
                        },
                        child: Center(
                          child: Text('????ng nh???p',
                              style: Theme.of(context).textTheme.button),
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
                          'Qu??n m???t kh???u',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
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
                'B???n ch??a c?? t??i kho???n ?',
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
                child: Text('????ng k??',
                    style: Theme.of(context).textTheme.headline2),
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
                title: Text("B???n c?? mu???n tho??t ???ng d???ng?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("C??")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Kh??ng"))
                ],
              );
            });
        return rs == true;
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoadingState) {
          return CircularProgressIndicator(
              color: AppTheme.circleProgressIndicatorColor);
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
