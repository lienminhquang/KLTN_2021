import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class AppModel extends ChangeNotifier {
  bool isSignedIn = false;

  final UserServices _userServices = UserServices();

  Future<ApiResult<bool>> login(LoginVM loginVM) async {
    var loginResult = await _userServices.login(loginVM);
    isSignedIn = loginResult.isSuccessed;
    // Todo: we need to get userinfo here
    notifyListeners();
    return loginResult;
  }
}
