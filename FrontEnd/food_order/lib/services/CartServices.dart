import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Carts/CartCreateVM.dart';
import 'package:food_delivery/view_models/Carts/CartVM.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
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
          "Server error! Please re-try later!");
    }
    try {
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
    } catch (e) {}

    return ApiResult.failedApiResult("Error!!");
  }

  Future<ApiResult<bool>> addToCart(
      String userID, int foodID, int quantity) async {
    log("Add to cart: $userID $foodID $quantity");
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;
    CartCreateVM cartCreateVM = CartCreateVM();
    cartCreateVM.appUserId = userID;
    cartCreateVM.foodID = foodID;
    cartCreateVM.quantity = quantity;
    try {
      response = await ioClient.post(Uri.parse(baseRoute),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(cartCreateVM));
    } catch (e) {
      return ApiResult<bool>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result = ApiResult<CartVM>.fromJson(
          json, (a) => CartVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("Cart create succesed!");
        log("Cart: " + result.payLoad!.toString());
        return ApiResult.succesedApiResult(true);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    } catch (e) {}

    return ApiResult.failedApiResult("Error!!");
  }
}
