abstract class ChatEvent {}

class ChatStartedEvent extends ChatEvent {}

class ChatErrorEvent extends ChatEvent {
  final String error;
  ChatErrorEvent(this.error);
}

class ChatReconnectEvent extends ChatEvent {}

class ChatSendMessEvent extends ChatEvent {
  final String message;
  ChatSendMessEvent(this.message);
}
