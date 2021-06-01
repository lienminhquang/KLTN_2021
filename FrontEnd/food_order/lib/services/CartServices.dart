import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Carts/CartCreateVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class CartServices {
  final String baseRoute = AppConfigs.URL_CartsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<CartVM>>> getAllByUserID(String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/user?userID=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<CartVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<CartVM>>.fromJson(json, (paginatedJson) {
        return PaginatedList<CartVM>.fromJson(
            paginatedJson as Map<String, dynamic>, (categoryJson) {
          return CartVM.fromJson(categoryJson as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        log("Fetched: " + result.payLoad!.items!.length.toString());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<CartVM>> getByID(int foodID, String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/details?foodID=$foodID&userId=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      print(e);
      return ApiResult<CartVM>.failedApiResult(
          "Could not connect to server! Please re-try later!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<CartVM>.fromJson(json, (foodJson) {
        return CartVM.fromJson(foodJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        print("Fetched CartVM: ");
        print(result.payLoad);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<bool>> delete(int foodID, String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "?foodID=$foodID&userId=$userID";
    Response? response;
    try {
      log("DELETE: " + url);
      response = await ioClient.delete(Uri.parse(url));
    } catch (e) {
      print(e);
      return ApiResult<bool>.failedApiResult(
          "Could not connect to server! Please re-try later!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<bool>.fromJson(json, (child) {
        return child as bool;
      });

      if (result.isSuccessed == true) {
        print("Deleted CartVM: foodID = $foodID, userID = $userID");
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<CartVM>> editOrCreate(
      int foodID, int quantity, String userID) async {
    log("editOrCreate cart: $userID $foodID $quantity");
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;
    CartCreateVM cartCreateVM = CartCreateVM();
    cartCreateVM.appUserId = userID;
    cartCreateVM.foodID = foodID;
    cartCreateVM.quantity = quantity;
    try {
      String url = baseRoute + "/edit_or_create";
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(cartCreateVM));
    } catch (e) {
      return ApiResult<CartVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<CartVM>.fromJson(
          json, (a) => CartVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("Cart create succesed!");
        log("Cart: " + result.payLoad!.toString());
      }
      return result;
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
