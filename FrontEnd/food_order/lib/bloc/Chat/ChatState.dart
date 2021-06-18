import 'package:food_delivery/pages/chatbot/chatmessage.dart';

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<ChatMessage> messages;
  ChatLoadedState(this.messages);
}
