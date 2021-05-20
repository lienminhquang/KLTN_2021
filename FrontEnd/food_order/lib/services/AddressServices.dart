import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Addresses/AddressCreateVM.dart';
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
    IOClient ioClient = _httpClientFactory.createIOClient();
    final String url = baseRoute + "/user?userID=$userID";
    Response? response;
    try {
      log("GET: " + url);
      response = await ioClient.get(Uri.parse(url));
    } catch (e) {
      return ApiResult<PaginatedList<AddressVM>>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
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
    } catch (e) {
      print(e);
    }

    return ApiResult.failedApiResult("Error!!");
  }

  Future<ApiResult<bool>> delete(id) async {
    return ApiResult.failedApiResult("errorMessage");
  }

  Future<ApiResult<AddressVM>> create(
      String name, String addressString, String userID) async {
    log("Create address: $userID $name $addressString");
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;
    AddressCreateVM createVM = AddressCreateVM();
    createVM.appUserID = userID;
    createVM.name = name;
    createVM.addressString = addressString;
    try {
      String url = baseRoute;
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(createVM));
    } catch (e) {
      return ApiResult<AddressVM>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result = ApiResult<AddressVM>.fromJson(
          json, (a) => AddressVM.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("AddressVM create succesed!");
        log("AddressVM: " + result.payLoad!.toString());
      }
      return result;
    } catch (e) {
      return ApiResult.failedApiResult(e.toString());
    }
  }
}
