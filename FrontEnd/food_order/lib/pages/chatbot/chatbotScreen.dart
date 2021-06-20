import 'package:flutter/material.dart';

import 'ChatBody.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Amee assistant'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: ChatBody(),
      ),
    );
  }
}
