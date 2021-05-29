import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PromotionVM.g.dart';

@JsonSerializable()
class PromotionVM {
  PromotionVM();
  late int id;
  late String name;
  late String code;
  String? desciption;
  late DateTime startDate;
  late DateTime endDate;
  int? useTimes;
  late double percent;
  late bool enabled;
  int? max;
  int? minPrice;
  late bool isGlobal;

  @JsonKey(ignore: true)
  late List<FoodVM> foodVMs;

  factory PromotionVM.fromJson(Map<String, dynamic> json) =>
      _$PromotionVMFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionVMToJson(this);
}
