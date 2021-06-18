import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
import 'package:food_delivery/pages/chatbot/chatmessage.dart';

import 'dart:async';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';

import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:food_delivery/services/CategoriesServices.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadingState());
  final List<ChatMessage> _messages = <ChatMessage>[];
  DialogflowGrpcV2Beta1? dialogflow;
  CategoriesServices _categoriesServices = CategoriesServices();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatSendMessEvent) {
      //yield ChatLoadedState(_messages);
// send messgage
      await sendMessage(event.message);

      yield ChatLoadedState(_messages);
    }
  }

  Future<void> sendMessage(String message) async {
    // Dialogflow Code
    ChatMessage chatMessage = ChatMessage(
      text: message,
      name: 'You',
      type: true,
    );

    _messages.insert(0, chatMessage);

    DetectIntentResponse data =
        await dialogflow!.detectIntent(message, 'en-US');

    String fulfillmentText = data.queryResult.fulfillmentText;
    if (fulfillmentText.isNotEmpty) {
      switch (data.queryResult.parameters.fields['esanpham']!.stringValue) {
        case 'Cơm':
          {
            ChatMessage botMessage = ChatMessage(
              text:
                  fulfillmentText + 'du lieu cua com', // text response của Bot
              name: "Bot",
              type: false,
            );
            var rs = await _categoriesServices.getFoodsInCategory(2);
            if (rs.isSuccessed == false) {
// show error message
              return;
            }
            var listFood = rs.payLoad!.items;
            _messages.insert(0, botMessage);
          }
          break;

        case 'Bò':
          {
            ChatMessage botMessage = ChatMessage(
              text: fulfillmentText + 'du lieu cua bo', // text response của Bot
              name: "Bot",
              type: false,
            );
            _messages.insert(0, botMessage);
          }
          break;
        case 'Trà sữa':
          {
            ChatMessage botMessage = ChatMessage(
              text: fulfillmentText +
                  'du lieu cua tra sua', // text response của Bot
              name: "Bot",
              type: false,
            );
            _messages.insert(0, botMessage);
          }
          break;
        case 'Bánh ngọt':
          {
            ChatMessage botMessage = ChatMessage(
              text: fulfillmentText +
                  'du lieu cua banh ngot', // text response của Bot
              name: "Bot",
              type: false,
            );
            _messages.insert(0, botMessage);
          }
          break;

        default:
          {
            ChatMessage botMessage = ChatMessage(
              text: fulfillmentText, // text response của Bot
              name: "Bot",
              type: false,
            );
            _messages.insert(0, botMessage);
          }
          break;
      }
    }
  }
}
