import 'package:food_delivery/view_models/SaleCampaigns/SaleCampaignVM.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FoodVM.g.dart';

@JsonSerializable(explicitToJson: true)
class FoodVM {
  FoodVM(
      {this.id = -1,
      this.name = "",
      this.description = "",
      this.price = 0,
      this.count = 0,
      this.imagePath = "",
      this.agvRating = 0,
      this.totalRating = 0,
      this.saleCampaignVM});

  int id;
  String name;
  String description;
  double price;
  int count;
  String imagePath;
  double agvRating;
  int totalRating;

  SaleCampaignVM? saleCampaignVM;

  factory FoodVM.fromJson(Map<String, dynamic> json) => _$FoodVMFromJson(json);
  Map<String, dynamic> toJson() => _$FoodVMToJson(this);
}
