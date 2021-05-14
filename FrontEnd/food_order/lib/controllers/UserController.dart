import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/Users/LoginVM.dart';
import 'package:food_delivery/models/commons/ApiResult.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class UserController {
  static String? JWT;
  final String baseRoute = AppConfigs.URL_UserRouteAPI;

  Future<ApiResult<bool>> login(LoginVM loginVM) async {
    log("LoginVM " + jsonEncode(loginVM.toJson()));
    IOClient ioClient = HttpClientFactory.createIOClient();
    Response? response;
    try {
      response = await ioClient.post(Uri.parse(baseRoute + '/Login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(loginVM));
    } catch (e) {
      return ApiResult<bool>.failedApiResult(
          "Server error! Please re-try later!");
    }
    try {
      var json = jsonDecode(response.body);
      var result = ApiResult<String>.fromJson(json, (a) => a.toString());
      if (result.isSuccessed == true) {
        log("Signin succesed!");
        log("JWT: " + result.payLoad!);
        JWT = result.payLoad;
        return ApiResult.succesedApiResult(true);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    } catch (e) {}

    return ApiResult.failedApiResult("Error!!");
  }
}
