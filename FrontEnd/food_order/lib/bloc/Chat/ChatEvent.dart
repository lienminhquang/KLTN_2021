abstract class ChatEvent {}

class ChatStartedEvent extends ChatEvent {}

class ChatSendMessEvent extends ChatEvent {
  final String message;
  ChatSendMessEvent(this.message);
}
