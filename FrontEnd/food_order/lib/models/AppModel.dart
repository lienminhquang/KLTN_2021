import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/CartServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class AppModel extends ChangeNotifier {
  String JWT = "";
  String userID = "5d597675-8179-4575-7872-08d90b25fb90";

  final UserServices _userServices = UserServices();

  Future<ApiResult<bool>> login(LoginVM loginVM) async {
    var loginResult = await _userServices.login(loginVM);
    // Todo: we need to get userinfo here
    return loginResult;
  }
}
