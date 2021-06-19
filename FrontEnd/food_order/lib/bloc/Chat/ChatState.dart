import 'package:food_delivery/pages/chatbot/MessageWidget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<types.Message> messages;
  final types.User user;
  ChatLoadedState(this.messages, this.user);
}
