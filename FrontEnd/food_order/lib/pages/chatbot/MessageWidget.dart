import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/view_models/ChatBots/MessageData.dart';

class MessageDataWrapper {
  MessageDataWrapper({
    required this.data,
    required this.name,
    required this.type,
  });

  final MessageData data;
  final String name;
  final bool type;
}

class MessageWidget extends StatelessWidget {
  final MessageDataWrapper _messageDataWrapper;
  MessageWidget(this._messageDataWrapper);

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: CircleAvatar(child: Icon(Icons.support_agent_outlined)),
          backgroundColor: Colors.orange,
        ),
      ),
      new Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(_messageDataWrapper.data.text == null
                  ? ""
                  : _messageDataWrapper.data.text!), //lam khung chat o day
            ),
            _buidAttachmentWidget(context, _messageDataWrapper)
          ],
        ),
      ),
    ];
  }

  Widget _buidAttachmentWidget(
      BuildContext context, MessageDataWrapper dataWrapper) {
    var attachment = dataWrapper.data.attachment;
    if (attachment != null && attachment['type'] == 'image') {
      var src = attachment['payload']['src'];
      return Container(
        width: 200,
        height: 100,
        child: CachedNetworkImage(
          imageUrl: src,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      );
    }
    return Container();
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                // lafm khung chat o day

                _messageDataWrapper.data.text == null
                    ? ""
                    : _messageDataWrapper.data.text!,
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(child: Icon(Icons.person)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _messageDataWrapper.type
            ? myMessage(context)
            : otherMessage(context),
      ),
    );
  }
}
