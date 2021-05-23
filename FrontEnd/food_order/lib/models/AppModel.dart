import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/NotificationServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Notifications/NotificationVM.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class AppModel extends ChangeNotifier {
  bool isSignedIn = false;

  final UserServices _userServices = UserServices();
  final NotificationServices _notificationServices = NotificationServices();

  List<NotificationVM> unreadedNotification = [];
  bool _isFetchNotificationScheduled = false;

  Future<ApiResult<bool>> login(LoginVM loginVM) async {
    var loginResult = await _userServices.login(loginVM);
    isSignedIn = loginResult.isSuccessed;
    // Todo: we need to get userinfo here
    notifyListeners();
    return loginResult;
  }
}
