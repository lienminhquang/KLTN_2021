import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class PromotionServices {
  final String baseRoute = AppConfigs.URL_PromotionsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<PromotionVM>>> getAllValid(
      String userID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/valid?userID=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<PromotionVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<PromotionVM>>.fromJson(json, (foodJson) {
        return PaginatedList<PromotionVM>.fromJson(
            foodJson as Map<String, dynamic>, (value) {
          return PromotionVM.fromJson(value as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        print("Fetched Promotion list: ");
        print(result.payLoad!.items);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<PromotionVM>> getByID(int id) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/$id";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PromotionVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<PromotionVM>.fromJson(json, (foodJson) {
        return PromotionVM.fromJson(foodJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        print("Fetched PromotionVM: ");
        print(result.payLoad);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
