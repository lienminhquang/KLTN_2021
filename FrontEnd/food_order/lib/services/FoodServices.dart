import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class FoodServices {
  final String baseRoute = AppConfigs.URL_FoodRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<FoodVM>> getFoodByID(int id) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/$id";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<FoodVM>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result = ApiResult<FoodVM>.fromJson(json, (foodJson) {
        return FoodVM.fromJson(foodJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        print("Fetched Food: ");
        print(result.payLoad);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    } catch (e) {
      print(e);
    }

    return ApiResult.failedApiResult("Error!!");
  }
}
