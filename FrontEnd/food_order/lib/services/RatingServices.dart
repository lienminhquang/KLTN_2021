import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class RatingServices {
  final String baseRoute = AppConfigs.URL_RatingsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<RatingVM>>> getRatingsOfFood(
      int foodID) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/food?foodID=$foodID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<RatingVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<RatingVM>>.fromJson(json, (foodJson) {
        return PaginatedList<RatingVM>.fromJson(
            foodJson as Map<String, dynamic>, (value) {
          return RatingVM.fromJson(value as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        print("Fetched RatingList: ");
        print(result.payLoad!.items);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
