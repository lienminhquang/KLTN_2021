import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Orders/OrderCreateVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';
import 'UserServices.dart';

class OrderServices {
  final String baseRoute = AppConfigs.URL_OrdersRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<List<OrderVM>>> getAllByUserID(String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/user?userID=$userID";
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
      return ApiResult<List<OrderVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
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
    }
    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<OrderVM>> getByID(int orderID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/$orderID";
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
      return ApiResult<OrderVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<OrderVM>.fromJson(json, (json) {
        return OrderVM.fromJson(json as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        log("Fetched: OrderDetails" + result.payLoad!.toString());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }
    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<OrderVM>> create(OrderCreateVM orderCreateVM) async {
    log("editOrCreate cart: ${orderCreateVM.toJson()}");
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;

    try {
      String url = baseRoute;
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + UserServices.JWT!
          },
          body: jsonEncode(orderCreateVM));
    } catch (e) {
      return ApiResult<OrderVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.Created ||
        response.statusCode == HTTPStatusCode.BadRequest) {
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
    }
    return ApiResult.failedApiResult("Some thing went wrong!");
    // } catch (e) {
    //   log("[Failed] " + e.toString());
    //   return ApiResult.failedApiResult(e.toString());
    // }
  }
}
