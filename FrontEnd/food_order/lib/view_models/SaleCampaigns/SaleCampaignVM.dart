import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SaleCampaignVM.g.dart';

@JsonSerializable()
class SaleCampaignVM {
  SaleCampaignVM();
  late int id;
  late String name;
  late String desciption;
  late DateTime startDate;
  late DateTime endDate;
  late double percent;
  late bool enabled;
  late int priority;

  late List<FoodVM>? foodVMs;

  factory SaleCampaignVM.fromJson(Map<String, dynamic> json) =>
      _$SaleCampaignVMFromJson(json);
  Map<String, dynamic> toJson() => _$SaleCampaignVMToJson(this);
}
