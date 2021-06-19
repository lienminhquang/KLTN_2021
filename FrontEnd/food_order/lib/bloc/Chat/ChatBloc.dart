import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
import 'package:food_delivery/pages/chatbot/MessageWidget.dart';

import 'dart:async';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';

import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/services/ChatBotServices.dart';
import 'package:food_delivery/view_models/ChatBots/MessageData.dart';
import 'package:food_delivery/view_models/ChatBots/SendMessageRequest.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadingState()) {
    _socket.on('connect', (id) {
      print("Socked connected");
      this.add(ChatStartedEvent());
    });
    _socket.onError((data) {
      print("Socket error: ");
      print(data);
    });

    _socket.on('connect_error', (data) {
      print("connect_error: ");
      print(data);
    });

    _socket.on('error', (data) {
      print("error: ");
      print(data);
    });

    _socket.on('connect_timeout', (data) {
      print("connect_timeout: ");
      print(data);
    });
    _socket.on('disconnect', (data) {
      print("disconnect: ");
      print(data);
    });
    _socket.on('reconnecting', (data) {
      print("reconnecting: ");
      print(data);
    });
    _socket.on('reconnect_failed', (data) {
      print("reconnect_failed: ");
      print(data);
    });
    _socket.on('reconnect_error', (data) {
      print("reconnect_error: ");
      print(data);
    });

    _socket.on('bot_uttered', _onBotUttered);
  }
  List<types.Message> _messages = [];
  DialogflowGrpcV2Beta1? dialogflow;
  CategoriesServices _categoriesServices = CategoriesServices();
  ChatBotServices _chatBotServices = ChatBotServices();
  var _user = const types.User(
      id: '06c33e8b-e835-4736-80f4-63f44b66666c',
      firstName: "lmq",
      lastName: "quang");
  var _bot = const types.User(
      id: '0a8e1841-05e7-42d3-8bc0-9c05be14f74e',
      firstName: "",
      lastName: "Amee");

  Socket _socket = io(
      'http://localhost:5005',
      OptionBuilder()
          .setPath("/socket.io")
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          //.setExtraHeaders({'t': 'NeY6Mw0'}) // optional
          .build());

  void _onBotUttered(data) {
    var map = data as Map<String, dynamic>;
    print("Bot uttered: " + map.toString());
    var res = MessageData.fromJson(map);

    if (res.text != null && res.attachment == null) {
      final textMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _randomString(),
        text: res.text!,
      );
      _messages.insert(0, textMessage);
    } else {
      if (res.attachment!['type'] == 'image') {
        final imageMessage = types.ImageMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          //height: image.height.toDouble(),
          id: _randomString(),
          name: "image",
          size: 0,
          uri: res.attachment!['payload']['src'],
          //width: image.width.toDouble(),
        );
        _messages.insert(0, imageMessage);
      }
    }

    // todo may be we need the difference event here
    this.add(ChatStartedEvent());
  }

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatStartedEvent) {
      if (_socket.disconnected) {
        print("Socket connecting!");
        _socket.connect();
        yield ChatLoadingState();
      } else {
        //print("Socket is ready!");
        yield ChatLoadedState(_messages, _user);
      }
    }
    if (event is ChatSendMessEvent) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _randomString(),
        text: event.message,
      );
      _messages.insert(0, textMessage);

      yield ChatLoadedState(_messages, _user);

      await sendMessage(event.message);
    }
  }

  Future<void> sendMessage(String message) async {
    var messageRequest = SendMessageRequest("test", message).toJson();

    print("sending message:" + messageRequest.toString());

    _socket.emit("user_uttered", messageRequest);
  }
}
