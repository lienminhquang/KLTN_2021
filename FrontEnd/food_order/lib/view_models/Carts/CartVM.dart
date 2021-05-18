import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CartVM.g.dart';

@JsonSerializable(explicitToJson: true)
class CartVM {
  CartVM();

  String appUserId = "";
  int foodID = 0;
  int quantity = 0;
  FoodVM foodVM = FoodVM();

  factory CartVM.fromJson(Map<String, dynamic> json) => _$CartVMFromJson(json);
  Map<String, dynamic> toJson() => _$CartVMToJson(this);
}
