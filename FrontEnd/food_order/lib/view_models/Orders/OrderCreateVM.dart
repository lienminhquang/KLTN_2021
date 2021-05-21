import 'package:json_annotation/json_annotation.dart';

part 'OrderCreateVM.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderCreateVM {
  OrderCreateVM();
  OrderCreateVM.explicit({
    required this.appUserID,
    required this.isPaid,
    this.datePaid,
    required this.orderStatusID,
    this.promotionID,
    required this.promotionAmount,
    required this.addressString,
    required this.addressName,
  });
  late String appUserID;

  late bool isPaid;
  DateTime? datePaid;
  late int orderStatusID;
  int? promotionID;
  double? promotionAmount;

  late String addressString;
  late String addressName;

  //late List<int> cartIDs;

  factory OrderCreateVM.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateVMFromJson(json);
  Map<String, dynamic> toJson() => _$OrderCreateVMToJson(this);
}
