import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
//import 'package:food_delivery/pages/chatbot/MessageWidget.dart';

import 'dart:async';

import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/ChatBots/MessageData.dart';
import 'package:food_delivery/view_models/ChatBots/SendMessageRequest.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadingState()) {
    final userID = UserServices.getUserID();
    final username = UserServices.getUsername();
    _user = types.User(id: userID, firstName: "", lastName: username);
    _bot = types.User(
        id: '0a8e1841-05e7-42d3-8bc0-9c05be14f74e',
        imageUrl: AppConfigs.URL_Images + "/icons/" + "icons8-bot-64.png",
        firstName: "",
        lastName: "Amee");

    _socket.on('connect', (id) {
      print("Socked connected");
      _socket.emit("session_request", {"session_id": _user.id});
      this.add(ChatStartedEvent());
    });
    _socket.onError((data) {
      print("Socket error: ");
      print(data);
    });

    _socket.on('connect_error', (data) {
      this.add(ChatErrorEvent("Could not connect to server!"));
      _socket.disconnect();
      print("connect_error: ");
      print(data);
    });

    _socket.on('error', (data) {
      print("error: ");
      print(data);
    });

    _socket.on('connect_timeout', (data) {
      this.add(ChatErrorEvent("Could not connect to server!"));
      _socket.disconnect();
      print("connect_timeout: ");
      print(data);
    });
    _socket.on('disconnect', (data) {
      this.add(ChatErrorEvent("Could not connect to server!"));
      _socket.disconnect();
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

  late final types.User _user;
  late final types.User _bot;

  Socket _socket = io(
      'http://localhost:5005',
      OptionBuilder()
          .setPath("/socket.io")
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          // .setExtraHeaders({
          //   'sid': 'lmqqlmqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq'
          // }) // optional
          .build());

  void _onBotUttered(data) {
    print(data);
    if (data is Map<String, dynamic>) {
      if (data['type'] == "list_food" || data['type'] == "list_order") {
        var list_food = data['list_food'];
        var list_order = data['list_order'];
        print("Bot uttered list food: ");
        print(list_food);

        var message = types.CustomMessage(
            author: _bot,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: _randomString(),
            metadata: {
              'type': data['type'],
              'payload': list_food == null ? list_order : list_food
            });
        _messages.insert(0, message);
      } else {
        var map = data;
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
      }
      // todo may be we need the difference event here
      this.add(ChatStartedEvent());
    }
  }

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatReconnectEvent) {
      if (_socket.disconnected) {
        _socket.connect();
      }
      return;
    }
    if (event is ChatErrorEvent) {
      yield ChatErrorState(event.error);
      return;
    }
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
    var messageRequest = SendMessageRequest(_user.id, message).toJson();

    print("sending message:" + messageRequest.toString());

    //_socket.emit("user_uttered", {"session_id": _user.id, "message": message});
    _socket.emit("user_uttered", messageRequest);
  }
}
