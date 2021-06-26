import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Addresses/AddressCreateVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressEditVM.dart';
import 'package:food_delivery/view_models/Addresses/AddressVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/view_models/commons/PaginatedList.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

class AddressServices {
  final String baseRoute = AppConfigs.URL_AddressesRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<PaginatedList<AddressVM>>> getAddressOfUser(
      String userID) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
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
      return ApiResult<PaginatedList<AddressVM>>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result =
          ApiResult<PaginatedList<AddressVM>>.fromJson(json, (foodJson) {
        return PaginatedList<AddressVM>.fromJson(
            foodJson as Map<String, dynamic>, (value) {
          return AddressVM.fromJson(value as Map<String, dynamic>);
        });
      });

      if (result.isSuccessed == true) {
        print("Fetched Address list: ");
        print(result.payLoad!.items);
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<AddressVM>> create(AddressCreateVM addressCreateVM) async {
    log("Create address: ${addressCreateVM.toJson()}");
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
          body: jsonEncode(addressCreateVM));
    } catch (e) {
      return ApiResult<AddressVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<AddressVM>.fromJson(
          json, (a) => AddressVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("AddressVM create succesed!");
        log("AddressVM: " + result.payLoad!.toString());
      }
      return result;
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<AddressVM>> edit(AddressEditVM addressEditVM) async {
    log("Edit address: ${addressEditVM.toJson()}");
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    Response? response;

    try {
      String url = baseRoute + "?id=${addressEditVM.id}";
      log("PUT $url");
      response = await ioClient.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + UserServices.JWT!
          },
          body: jsonEncode(addressEditVM));
    } catch (e) {
      return ApiResult<AddressVM>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<AddressVM>.fromJson(
          json, (a) => AddressVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("AddressVM Edit succesed!");
        log("AddressVM: " + result.payLoad!.toString());
      }
      return result;
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  Future<ApiResult<bool>> delete(int id) async {
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    final String url = baseRoute + "?id=$id";
    Response? response;
    try {
      log("DELETE: " + url);
      response = await ioClient.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer ' + UserServices.JWT!
        },
      );
    } catch (e) {
      print(e);
      return ApiResult<bool>.failedApiResult(
          "Could not connect to server! Please re-try later!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<bool>.fromJson(json, (child) {
        return child as bool;
      });

      if (result.isSuccessed == true) {
        print("Deleted Address: id = $id");
        return ApiResult.succesedApiResult(result.payLoad);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
