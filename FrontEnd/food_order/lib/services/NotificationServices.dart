import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/Notifications/NotificationReceivedVM.dart';
import 'package:food_delivery/view_models/Notifications/NotificationVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';
import 'UserServices.dart';

class NotificationServices {
  final String baseRoute = AppConfigs.URL_NotificationsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<NotificationVM>>> getUnreceivedNotifications(
      String userID) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    final String url = baseRoute + "/unreceived?userID=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer ' + UserServices.JWT!
        },
      );
    } catch (e) {
      return ApiResult<PaginatedList<NotificationVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<NotificationVM>>.fromJson(json, (foodJson) {
        return PaginatedList<NotificationVM>.fromJson(
            foodJson as Map<String, dynamic>, (value) {
          return NotificationVM.fromJson(value as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        print("Fetched NotificationVM list: ");
        print(result.payLoad!.items);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<bool>> notificationReceived(
      int notificationID, String userID) async {
    log("notificationReceived: $notificationID by $userID");
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    Response? response;
    NotificationReceivedVM notificationReceivedVM = NotificationReceivedVM();
    notificationReceivedVM.notificationID = notificationID;
    notificationReceivedVM.receiverID = userID;
    try {
      String url = baseRoute + "/received";
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + UserServices.JWT!
          },
          body: jsonEncode(notificationReceivedVM));
    } catch (e) {
      return ApiResult<bool>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<bool>.fromJson(json, (a) => a as bool);
      if (result.isSuccessed == true) {
        log("notificationReceived succesed!");
        log("notificationReceived: " + result.payLoad!.toString());
      }
      return result;
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<AddressVM>> edit(
      int id, String userID, String name, String addressString) async {
    log("Edit address: $userID $name $addressString");
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    Response? response;
    AddressEditVM editVM = AddressEditVM();
    editVM.id = id;
    editVM.appUserID = userID;
    editVM.name = name;
    editVM.addressString = addressString;
    try {
      String url = baseRoute + "?id=$id";
      log("PUT $url");
      response = await ioClient.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + UserServices.JWT!
          },
          body: jsonEncode(editVM));
    } catch (e) {
      return ApiResult<AddressVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<AddressVM>.fromJson(
          json, (a) => AddressVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("AddressVM Edit succesed!");
        log("AddressVM: " + result.payLoad!.toString());
      }
      return result;
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<bool>> delete(int id) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    final String url = baseRoute + "?id=$id";
    Response? response;
    try {
      log("DELETE: " + url);
      response = await ioClient.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer ' + UserServices.JWT!
        },
      );
    } catch (e) {
      print(e);
      return ApiResult<bool>.failedApiResult(
          "Could not connect to server! Please re-try later!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<bool>.fromJson(json, (child) {
        return child as bool;
      });

      if (result.isSuccessed == true) {
        print("Deleted Address: id = $id");
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
