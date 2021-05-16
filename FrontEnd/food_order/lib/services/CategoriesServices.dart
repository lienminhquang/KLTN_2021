import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:food_delivery/view_models/commons/PagingRequest.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class CategoriesServices {
  final String baseRoute = AppConfigs.URL_CategoryRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<CategoryVM>>> getAllPaging() async {
    PagingRequest pagingRequest = PagingRequest();
    pagingRequest.PageNumber = 1;
    pagingRequest.SearchString = "";
    pagingRequest.SortOrder = "";

    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute +
        "?pageNumber=${pagingRequest.PageNumber}&searchString=${pagingRequest.SearchString}&sortOrder=${pagingRequest.SortOrder}";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<CategoryVM>>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<CategoryVM>>.fromJson(json, (paginatedJson) {
        return PaginatedList.fromJson(paginatedJson as Map<String, dynamic>,
            (categoryJson) {
          return CategoryVM.fromJson(categoryJson as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        log("Fetched: " + result.payLoad!.toString());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    } catch (e) {}

    return ApiResult.failedApiResult("Error!!");
  }

  Future<ApiResult<PaginatedList<FoodVM>>> getFoodsInCategory(int id) async {
    PagingRequest pagingRequest = PagingRequest();
    pagingRequest.PageNumber = 1;
    pagingRequest.SearchString = "";
    pagingRequest.SortOrder = "";

    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute +
        "/$id/foods?pageNumber=${pagingRequest.PageNumber}&searchString=${pagingRequest.SearchString}&sortOrder=${pagingRequest.SortOrder}";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<FoodVM>>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<FoodVM>>.fromJson(json, (paginatedJson) {
        return PaginatedList.fromJson(paginatedJson as Map<String, dynamic>,
            (categoryJson) {
          return FoodVM.fromJson(categoryJson as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        log("Fetched: " + result.payLoad!.toString());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    } catch (e) {}

    return ApiResult.failedApiResult("Error!!");
  }
}
