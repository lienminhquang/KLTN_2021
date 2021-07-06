import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/helper/TokenParser.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/LoginResponse.dart';
import 'package:food_delivery/view_models/Users/LoginVM.dart';
import 'package:food_delivery/view_models/Users/RefreshTokenRequest.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class HttpClientFactory {
  IOClientWrapper createIOClientWrapper() {
    // ..badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) {
    //   return true;
    // });
    try {
      var client = new IOClientWrapper();
      return client;
    } catch (e) {
      print(e.toString());
    }
    return new IOClientWrapper();
  }
}

class IOClientWrapper {
  late final IOClient _ioClient;

  Future<ApiResult<LoginResponse>> refreshToken() async {
    if (UserServices.RefreshToken == null ||
        UserServices.RefreshTokenExpire == null ||
        UserServices.RefreshTokenExpire!.compareTo(DateTime.now().toUtc()) <
            0) {
      return ApiResult.failedApiResult("Invalid token");
    }
    RefreshTokenRequest refreshTokenRequest =
        RefreshTokenRequest(UserServices.JWT!, UserServices.RefreshToken!);

    log("RefreshTokenRequest " + jsonEncode(refreshTokenRequest.toJson()));

    Response? response;
    try {
      response = await _ioClient.post(
          Uri.parse(AppConfigs.URL_UserRouteAPI + '/RefreshToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(refreshTokenRequest));
    } catch (e) {
      return ApiResult<LoginResponse>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.badRequest) {
      var json = jsonDecode(response.body);
      var result = ApiResult<LoginResponse>.fromJson(
          json, (a) => LoginResponse.fromJson(a as Map<String, dynamic>));
      if (result.isSuccessed == true) {
        log("Refresh token succesed!");
        log("Login response: " + result.payLoad!.toJson().toString());
        UserServices.JWT = result.payLoad!.accessToken;
        UserServices.RefreshToken = result.payLoad!.refreshToken;
        UserServices.RefreshTokenExpire = result.payLoad!.refreshTokenExpire;
        UserServices.PayloadMap = parseJWT(result.payLoad!.accessToken);
        print(UserServices.PayloadMap);
        return result;
      } else {
        return result;
      }
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }

  IOClientWrapper() {
    HttpClient httpClient = new HttpClient();
    this._ioClient = new IOClient(httpClient);
  }

  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    var response = await _ioClient.get(url, headers: headers);
    if (response.statusCode == HttpStatus.unauthorized) {
      var result = await refreshToken();
      if (result.isSuccessed) {
        headers!.update('Authorization', (value) {
          return 'Bearer ' + UserServices.JWT!;
        });
        return await _ioClient.get(url, headers: headers);
      }
    }
    return response;
  }

  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var response = await _ioClient.post(url,
        headers: headers, body: body, encoding: encoding);
    if (response.statusCode == HttpStatus.unauthorized) {
      var result = await refreshToken();
      if (result.isSuccessed) {
        headers!.update('Authorization', (value) {
          return 'Bearer ' + UserServices.JWT!;
        });
        return await _ioClient.get(url, headers: headers);
      }
    }
    return response;
  }

  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var response = await _ioClient.put(url,
        headers: headers, body: body, encoding: encoding);
    if (response.statusCode == HttpStatus.unauthorized) {
      var result = await refreshToken();
      if (result.isSuccessed) {
        headers!.update('Authorization', (value) {
          return 'Bearer ' + UserServices.JWT!;
        });
        return await _ioClient.get(url, headers: headers);
      }
    }
    return response;
  }

  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var response = await _ioClient.delete(url,
        headers: headers, body: body, encoding: encoding);
    if (response.statusCode == HttpStatus.unauthorized) {
      var result = await refreshToken();
      if (result.isSuccessed) {
        headers!.update('Authorization', (value) {
          return 'Bearer ' + UserServices.JWT!;
        });
        return await _ioClient.get(url, headers: headers);
      }
    }
    return response;
  }
}
