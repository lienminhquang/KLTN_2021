import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/SaleCampaigns/SaleCampaignVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class SaleCampaignServices {
  final String baseRoute = AppConfigs.URL_SaleCampaignsRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<SaleCampaignVM>>> getAllValid() async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/valid";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<SaleCampaignVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<SaleCampaignVM>>.fromJson(json, (foodJson) {
        return PaginatedList<SaleCampaignVM>.fromJson(
            foodJson as Map<String, dynamic>, (value) {
          return SaleCampaignVM.fromJson(value as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        print("Fetched SaleCampaignVM list: ");
        print(result.payLoad!.items);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<SaleCampaignVM>> getByID(int id) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/$id";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<SaleCampaignVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<SaleCampaignVM>.fromJson(json, (foodJson) {
        return SaleCampaignVM.fromJson(foodJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        print("Fetched SaleCampaign: ");
        print(result.payLoad);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
