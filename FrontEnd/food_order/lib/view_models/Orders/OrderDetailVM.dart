import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/SaleCampaigns/SaleCampaignVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

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
  int? saleCampaignID;
  double? salePercent;

  OrderVM? orderVM;
  FoodVM? foodVM;
  SaleCampaignVM? saleCampaign;
  RatingVM? ratingVM;

  factory OrderDetailVM.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailVMFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailVMToJson(this);
}
