import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:food_delivery/bloc/Chat/ChatBloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/food_detail/FoodDetail.dart';
import 'package:food_delivery/pages/oders/OrderItem.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/Orders/OrderDetailVM.dart';
import 'package:food_delivery/view_models/Orders/OrderStatusVM.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';

//import 'MessageWidget.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatBody extends StatefulWidget {
  ChatBody({Key? key}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  //final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isConnectingDialogShowing = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleSubmitted(String text, BuildContext context) async {
    context.read<ChatBloc>().add(ChatSendMessEvent(text));
    print(text);
    _textController.clear();
  }

  Widget _loadedState(BuildContext context, ChatLoadedState state) {
    return Chat(
        messages: state.messages,
        onSendPressed: _handleSendPressed,
        user: state.user,
        showUserAvatars: false,
        showUserNames: true,
        buildCustomMessage: (message) {
          return buildCustomeMessage(message as types.CustomMessage);
        });
  }

  void _handleSendPressed(types.PartialText message) {
    context.read<ChatBloc>().add(ChatSendMessEvent(message.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (_isConnectingDialogShowing) {
        Navigator.of(context).pop();
        _isConnectingDialogShowing = false;
      }
      if (state is ChatLoadedState) {
        return _loadedState(context, state);
      }
      if (state is ChatLoadingState) {
        return Container(
            child: Center(
          child: CircularProgressIndicator(
              color: AppTheme.circleProgressIndicatorColor),
        ));
      }
      if (state is ChatErrorState) {
        return Container(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message),
              TextButton(
                  onPressed: () {
                    context.read<ChatBloc>().add(ChatReconnectEvent());
                    _isConnectingDialogShowing = true;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return WillPopScope(
                            onWillPop: () async {
                              _isConnectingDialogShowing = false;
                              return true;
                            },
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              backgroundColor: Colors.black87,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Text(
                                      "Connecting ...",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                  ),
                                  CircularProgressIndicator(
                                      color: AppTheme
                                          .circleProgressIndicatorColor),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  child: Text("Reconnect"))
            ],
          ),
        ));
      }
      throw "Unknow state!";
    });
  }

  Widget buildCustomeMessage(types.CustomMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: _messageContent(message, context),
    );
  }

  Widget _messageContent(types.CustomMessage message, BuildContext context) {
    var type = message.metadata!['type'];
    if (type == 'list_food' || type == 'list_order') {
      var list = message.metadata!['payload'] as List;
      return Container(
        //height: 100.0 * list.length,
        child: Column(
            children: List.generate(list.length, (index) {
          if (type == 'list_food') {
            return FoodCard(
              foodVM: FoodVM.fromJson(list[index]),
              bottomBorder: BorderSide(width: 1.0, color: Colors.grey.shade300),
            );
          } else {
            return OrderItem(OrderVM()
              ..id = list[index]['id'] as int
              ..appUserID = list[index]['appUserID'] as String
              ..createdDate =
                  DateTime.parse(list[index]['createdDate'] as String)
              ..isPaid = list[index]['isPaid'] as bool
              ..datePaid = list[index]['datePaid'] == null
                  ? null
                  : DateTime.parse(list[index]['datePaid'] as String)
              ..orderStatusID = list[index]['orderStatusID'] as int
              ..promotionID = list[index]['promotionID'] as int?
              ..promotionAmount =
                  (list[index]['promotionAmount'] as num?)?.toDouble()
              ..addressString = list[index]['addressString'][0]
                  as String // ??? is that a bug ???
              ..addressName = list[index]['addressName'] as String
              ..orderDetailVMs = (list[index]['orderDetailVMs']
                      as List<dynamic>)
                  .map((e) => OrderDetailVM.fromJson(e as Map<String, dynamic>))
                  .toList()
              ..orderStatusVM = OrderStatusVM.fromJson(
                  list[index]['orderStatusVM'] as Map<String, dynamic>));
          }
        })),
      );
    }

    return Container();

    // final color = getUserAvatarNameColor(message.author,
    //     InheritedChatTheme.of(context).theme.userAvatarNameColors);
    // final name = getUserName(message.author);

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     if (showName)
    //       Padding(
    //         padding: const EdgeInsets.only(bottom: 6.0),
    //         child: Text(
    //           name,
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //           style: InheritedChatTheme.of(context)
    //               .theme
    //               .userNameTextStyle
    //               .copyWith(color: color),
    //         ),
    //       ),
    //     SelectableText(
    //       message.text,
    //       style: user.id == message.author.id
    //           ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
    //           : InheritedChatTheme.of(context)
    //               .theme
    //               .receivedMessageBodyTextStyle,
    //       textWidthBasis: TextWidthBasis.longestLine,
    //     ),
    //   ],
    // );
  }
}

class FoodCard extends StatelessWidget {
  final FoodVM foodVM;
  FoodCard({required this.foodVM, this.bottomBorder = BorderSide.none});
  final BorderSide bottomBorder;

  Widget _priceWidget(FoodVM foodVM) {
    if (foodVM.saleCampaignVM != null) {
      double discount = foodVM.saleCampaignVM!.percent;
      return Row(
        children: [
          Text(
            AppConfigs.toPrice(foodVM.price * (100 - discount) / 100) + "  ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Text(
            AppConfigs.toPrice(foodVM.price),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey),
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          AppConfigs.toPrice(foodVM.price),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          //top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
          //left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
          // right: BorderSide(width: 1.0, color: Color(0xFF000000)),
          bottom: bottomBorder,
        ),
      ),
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetail(
                        foodID: foodVM.id,
                        promotionID: null,
                      )));
        },
        child: Container(
          //height: 80,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    child: Stack(children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CircularProgressIndicator(
                          color: AppTheme.circleProgressIndicatorColor),
                      imageUrl: AppConfigs.URL_Images + "/${foodVM.imagePath}",
                    ),
                  ),
                ])),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: 130,
                height: 100,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          foodVM.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: _priceWidget(foodVM)),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      //width: 110,
                                      //color: Colors.white38,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          Text(
                                            "${foodVM.agvRating.toStringAsPrecision(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            " (${foodVM.totalRating})",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
