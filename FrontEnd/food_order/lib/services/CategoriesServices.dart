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
    pagingRequest.pageNumber = 1;
    pagingRequest.searchString = "";
    pagingRequest.sortOrder = "";

    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute +
        "?pageNumber=${pagingRequest.pageNumber}&searchString=${pagingRequest.searchString}&sortOrder=${pagingRequest.sortOrder}";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<CategoryVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<CategoryVM>>.fromJson(json, (paginatedJson) {
        return PaginatedList.fromJson(paginatedJson as Map<String, dynamic>,
            (categoryJson) {
          return CategoryVM.fromJson(categoryJson as Map<String, dynamic>);
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

  Future<ApiResult<CategoryVM>> getByID(int id) async {
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/$id";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<CategoryVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<CategoryVM>.fromJson(json, (paginatedJson) {
        return CategoryVM.fromJson(paginatedJson as Map<String, dynamic>);
      });

      if (result.isSuccessed == true) {
        log("Fetched: " + result.payLoad!.toJson().toString());
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<PaginatedList<FoodVM>>> getFoodsInCategory(int id) async {
    PagingRequest pagingRequest = PagingRequest();
    pagingRequest.pageNumber = 1;
    pagingRequest.searchString = "";
    pagingRequest.sortOrder = "";

    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute +
        "/$id/foods?pageNumber=${pagingRequest.pageNumber}&searchString=${pagingRequest.searchString}&sortOrder=${pagingRequest.sortOrder}";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<FoodVM>>.failedApiResult(
          "Could not connect to server! Please re-try later!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
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
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
