import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Orders/OrderCreateVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class OrderServices {
  final String baseRoute = AppConfigs.URL_OrdersRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<List<OrderVM>>> getAllByUserID(String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/user?userID=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<List<OrderVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    //try {
    var json = jsonDecode(response.body);
    var result = ApiResult<List<OrderVM>>.fromJson(json, (json) {
      return (json as List<dynamic>).map((e) => OrderVM.fromJson(e)).toList();
    });

    if (result.isSuccessed == true) {
      log("Fetched: " + result.payLoad!.length.toString());
      return ApiResult.succesedApiResult(result.payLoad);
    } else {
      return ApiResult.failedApiResult(result.errorMessage);
    }
    // } catch (e) {
    //   log("Error: ${e.toString()}");
    //   return ApiResult.failedApiResult("Error!!");
    // }
  }

  // Future<ApiResult<CartVM>> getByID(int foodID, String userID) async {
  //   IOClient ioClient = _httpClientFactory.createIOClient();
  //   final String url = baseRoute + "/details?foodID=$foodID&userId=$userID";
  //   Response? response;
  //   try {
  //     log("GET: " + url);
  //     response = await ioClient.get(Uri.parse(url));
  //   } catch (e) {
  //     print(e);
  //     return ApiResult<CartVM>.failedApiResult(
  //         "Could not connect to server! Please re-try later!");
  //   }
  //   try {
  //     var json = jsonDecode(response.body);
  //     var result = ApiResult<CartVM>.fromJson(json, (foodJson) {
  //       return CartVM.fromJson(foodJson as Map<String, dynamic>);
  //     });

  //     if (result.isSuccessed == true) {
  //       print("Fetched CartVM: ");
  //       print(result.payLoad);
  //       return ApiResult.succesedApiResult(result.payLoad);
  //     } else {
  //       return ApiResult.failedApiResult(result.errorMessage);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return ApiResult.failedApiResult("Error!!");
  // }

  // Future<ApiResult<bool>> delete(int foodID, String userID) async {
  //   IOClient ioClient = _httpClientFactory.createIOClient();
  //   final String url = baseRoute + "?foodID=$foodID&userId=$userID";
  //   Response? response;
  //   try {
  //     log("DELETE: " + url);
  //     response = await ioClient.delete(Uri.parse(url));
  //   } catch (e) {
  //     print(e);
  //     return ApiResult<bool>.failedApiResult(
  //         "Could not connect to server! Please re-try later!");
  //   }
  //   try {
  //     var json = jsonDecode(response.body);
  //     var result = ApiResult<bool>.fromJson(json, (child) {
  //       return child as bool;
  //     });

  //     if (result.isSuccessed == true) {
  //       print("Deleted CartVM: foodID = $foodID, userID = $userID");
  //       return ApiResult.succesedApiResult(result.payLoad);
  //     } else {
  //       return ApiResult.failedApiResult(result.errorMessage);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return ApiResult.failedApiResult("Error!!");
  // }

  Future<ApiResult<OrderVM>> create(OrderCreateVM orderCreateVM) async {
    log("editOrCreate cart: ${orderCreateVM.toJson()}");
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;

    try {
      String url = baseRoute;
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(orderCreateVM));
    } catch (e) {
      return ApiResult<OrderVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    // try {
    var json = jsonDecode(response.body);
    var result = ApiResult<OrderVM>.fromJson(
        json, (a) => OrderVM.fromJson(a as Map<String, dynamic>));
    if (result.isSuccessed == true) {
      log("OrderVM create succesed!");
      log("OrderVM: " + result.payLoad!.toJson().toString());
    } else {
      log("[Failed] " + result.errorMessage!);
    }
    return result;
    // } catch (e) {
    //   log("[Failed] " + e.toString());
    //   return ApiResult.failedApiResult(e.toString());
    // }
  }
}
