import 'package:food_delivery/view_models/Foods/FoodVM.dart';

import 'OrderVM.dart';

import 'package:json_annotation/json_annotation.dart';

part 'OrderDetailVM.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailVM {
  OrderDetailVM();
  late int orderID;
  late int foodID;
  late int amount;
  late double price;

  OrderVM? orderVM;
  FoodVM? foodVM;

  factory OrderDetailVM.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailVMFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailVMToJson(this);
}
