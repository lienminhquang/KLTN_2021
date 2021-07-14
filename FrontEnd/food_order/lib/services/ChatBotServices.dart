import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/ChatBots/MessageData.dart';

import 'package:food_delivery/view_models/ChatBots/SendMessageRequest.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'HttpClientFactory.dart';

// depredecated use now socketio instead of rest
class _ChatBotServices {
  final String baseRoute = AppConfigs.URL_BaseBotAPI;
  final HttpClientFactory _httpClientFactory = new HttpClientFactory();

  Future<ApiResult<MessageData>> sendMessage(
      SendMessageRequest sendMessageRequest) async {
    log("User send message to chat bot: ${sendMessageRequest.toJson()}");
    IOClientWrapper ioClient = _httpClientFactory.createIOClientWrapper();
    Response? response;

    try {
      String url = baseRoute;
      log("Post $url");
      response = await ioClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(sendMessageRequest));
    } catch (e) {
      return ApiResult<MessageData>.failedApiResult(
          "Could not connect to server. Check your connection!");
    }
    print(response.body);
    if (response.statusCode == HttpStatus.ok) {
      var json = jsonDecode(response.body);

      var messageResponse = MessageData.fromJson(json[0]);
      return ApiResult<MessageData>.succesedApiResult(messageResponse);
    }

    return ApiResult.failedApiResult("Some thing went wrong!");
  }
}
