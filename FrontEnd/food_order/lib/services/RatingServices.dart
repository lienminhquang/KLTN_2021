import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:food_delivery/view_models/ratings/RatingCreateVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class RatingServices {
  final String baseRoute = AppConfigs.URL_RatingsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<RatingVM>> create(RatingCreateVM ratingCreateVM) async {
    var userID = UserServices.getUserID();
    log("create rating: " + ratingCreateVM.toJson().toString());
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    Response? response;

    try {
      String url = baseRoute;
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + UserServices.JWT!
          },
          body: jsonEncode(ratingCreateVM));
    } catch (e) {
      return ApiResult<RatingVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<RatingVM>.fromJson(
          json, (a) => RatingVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("RatingVM create succesed!");
        log("RatingVM: " + result.payLoad!.toString());
      }
      return result;
    }
    log(response.toString());

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<RatingVM>> getByID(int orderID, int foodID) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    final String url = baseRoute + "/details?orderID=$orderID&foodID=$foodID";
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
      return ApiResult<RatingVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<RatingVM>.fromJson(json, (foodJson) {
        return RatingVM.fromJson(foodJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        print("Fetched rating: ");
        print(result.payLoad!.toJson());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<PaginatedList<RatingVM>>> getRatingsOfFood(
      int foodID) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    final String url = baseRoute + "/food?foodID=$foodID";
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
      return ApiResult<PaginatedList<RatingVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
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
