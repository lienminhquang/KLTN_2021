import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/NotificationServices.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Notifications/NotificationVM.dart';

class NotificationModel extends ChangeNotifier {
  final NotificationServices _notificationServices = NotificationServices();

  List<NotificationVM> unreadedNotification = [];
  bool _isFetchNotificationScheduled = false;

  Future<void> scheduleFetchNotification() async {
    if (_isFetchNotificationScheduled == true) {
      log("FetchNotification already scheduled!");
      return;
    }
    _isFetchNotificationScheduled = false;
    while (true) {
      unreadedNotification.clear();
      var notis = await _notificationServices
          .getUnreceivedNotifications(UserServices.getUserID());
      if (notis.isSuccessed == true) {
        unreadedNotification = notis.payLoad!.items!;
      }
      notifyListeners();
      await Future.delayed(Duration(seconds: 30));
    }
  }
}
