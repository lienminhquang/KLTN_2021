abstract class FoodDetailEvent {}

class FoodDetailStartedEvent extends FoodDetailEvent {
  final int foodID;
  FoodDetailStartedEvent(this.foodID);
}

class FoodDetailCreateCartEvent extends FoodDetailEvent {
  final int foodID;
  final int count;
  FoodDetailCreateCartEvent(this.foodID, this.count);
}
