import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/helper/TokenParser.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:food_delivery/services/FileServices.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class UserServices {
  static String? JWT;
  static Map<String, dynamic> PayloadMap = {};
  final String baseRoute = AppConfigs.URL_UserRouteAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();
  final String _userAccountFilename = "/Data.txt";

  UserServices();

  static String getUserID() {
    return PayloadMap["UserID"];
  }

  Future<ApiResult<Map<String, dynamic>>> getUserAccountFromCache() async {
    try {
      final FileServices fileServices = new FileServices();
      String cachePath = await fileServices.cachePath;
      String fullFilePath = cachePath + _userAccountFilename;
      File file = File(fullFilePath);
      String fileContent = await file.readAsString();
      dynamic json = jsonDecode(fileContent);
      log("loaded user from cache: " + json.toString());
      return ApiResult.succesedApiResult(json);
    } catch (e) {
      log("Failed to read useraccount form cache " + e.toString());
      return ApiResult.failedApiResult(
          "Failed to read useraccount form cache " + e.toString());
    }
  }

  Future<ApiResult<void>> saveUserAccountToCache(
      String username, String password) async {
    try {
      final FileServices fileServices = new FileServices();
      String cachePath = await fileServices.cachePath;
      String fullFilePath = cachePath + _userAccountFilename;

      Map<String, String> map = Map<String, String>();
      map["username"] = username;
      map["password"] = password;
      var json = jsonEncode(map);

      File file = File(fullFilePath);
      await file.writeAsString(json, mode: FileMode.write);

      log("Saved user to cache: " + json.toString());
      return ApiResult.succesedApiResult(json);
    } catch (e) {
      log("Failed to save useraccount to cache " + e.toString());
      return ApiResult.failedApiResult(
          "Failed to save useraccount to cache " + e.toString());
    }
  }

  Future<ApiResult<bool>> login(LoginVM loginVM) async {
    saveUserAccountToCache(loginVM.username!, loginVM.password!);

    log("LoginVM " + jsonEncode(loginVM.toJson()));
    IOClient ioClient = _httpClientFactory.createIOClient();
    Response? response;
    try {
      response = await ioClient.post(Uri.parse(baseRoute + '/Login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(loginVM));
    } catch (e) {
      return ApiResult<bool>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HTTPStatusCode.OK ||
        response.statusCode == HTTPStatusCode.BadRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<String>.fromJson(json, (a) => a.toString());
      if (result.isSuccessed == true) {
        log("Signin succesed!");
        log("JWT: " + result.payLoad!);
        JWT = result.payLoad;
        PayloadMap = parseJWT(result.payLoad!);
        print(PayloadMap);
        return ApiResult.succesedApiResult(true);
      } else {
        return ApiResult.failedApiResult(result.errorMessage);
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
