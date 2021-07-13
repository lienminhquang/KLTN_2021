import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/SignUp/SignUpBloc.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đổi mật khẩu',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHiddendenOldPassword = true;
  bool isHiddendenNewPassword = true;
  bool isHiddendenConfirmPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _toggleOldPasswordView() {
    isHiddendenOldPassword = !isHiddendenOldPassword;
    setState(() {});
  }

  void _toggleNewPasswordView() {
    isHiddendenNewPassword = !isHiddendenNewPassword;
    setState(() {});
  }

  void _toggleConfirmPasswordView() {
    isHiddendenConfirmPassword = !isHiddendenConfirmPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: 'Mật khẩu cũ',
                    prefix:
                        Icon(Icons.lock, color: Theme.of(context).buttonColor),
                    suffixIcon: InkWell(
                        onTap: _toggleOldPasswordView,
                        child: Icon(
                          Icons.visibility,
                        )),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  obscureText: isHiddendenOldPassword,
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
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu mới',
                    prefix:
                        Icon(Icons.lock, color: Theme.of(context).buttonColor),
                    suffixIcon: InkWell(
                        onTap: _toggleNewPasswordView,
                        child: Icon(
                          Icons.visibility,
                        )),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  obscureText: isHiddendenNewPassword,
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
                  decoration: InputDecoration(
                    hintText: 'Nhập lại mật khẩu mới',
                    prefix:
                        Icon(Icons.lock, color: Theme.of(context).buttonColor),
                    suffixIcon: InkWell(
                        onTap: _toggleConfirmPasswordView,
                        child: Icon(
                          Icons.visibility,
                        )),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  obscureText: isHiddendenConfirmPassword,
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
}
