import 'package:json_annotation/json_annotation.dart';

part 'PromotionVM.g.dart';

@JsonSerializable()
class PromotionVM {
  PromotionVM();
  late int iD;
  late String name;
  late String code;
  String? desciption;
  late DateTime createdDate;
  late DateTime startDate;
  late DateTime endDate;
  int? amount;
  late double percent;
  late bool enabled;
  int? max;
  int? minPrice;

  factory PromotionVM.fromJson(Map<String, dynamic> json) =>
      _$PromotionVMFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionVMToJson(this);
}
