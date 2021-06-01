abstract class OrderDetailsEvent {}

class OrderDetailStartedEvent extends OrderDetailsEvent {
  final int orderID;
  OrderDetailStartedEvent(this.orderID);
}
