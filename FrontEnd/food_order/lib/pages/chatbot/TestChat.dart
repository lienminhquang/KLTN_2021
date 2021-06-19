import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery/services/HttpClientFactory.dart';
import 'package:food_delivery/view_models/ChatBots/SendMessageRequest.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
//import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestChat extends StatefulWidget {
  final String title;

  TestChat({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _TestChatState createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  final TextEditingController _controller = TextEditingController();
  // final _channel = WebSocketChannel.connect(
  //   Uri.parse('ws://localhost:5005/socket.io'),
  // );

  // WebSocket('ws://localhost:5005/socket.io');
  //late WebSocket webSocket;
  Socket socket = io(
      'http://localhost:5005',
      OptionBuilder()
          .setPath("/socket.io")
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          //.setExtraHeaders({'t': 'NeY6Mw0'}) // optional

          .build());

  @override
  Widget build(BuildContext context) {
    // _channel.stream.listen((event) {
    //   print(event);
    // });
    socket.connect();
    socket.onConnectError((data) => print("error $data"));
    socket.onConnect((data) => print("onconnect $data"));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('bot_uttered', (data) {
      print("bot_uttered");
      print(data);
    });

    //socket.onConnect((data) => null)

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(height: 24),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      var message = SendMessageRequest("test", _controller.text);
      var str = message.toJson().toString();
      print(str);

      socket.emit("user_uttered", message.toJson());
    }
  }

  @override
  void dispose() {
    //webSocket.close();
    //_channel.sink.close();
    socket.close();
    super.dispose();
  }
}
