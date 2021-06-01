import 'package:food_delivery/view_models/Orders/OrderStatusVM.dart';

import 'OrderDetailVM.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderVM.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderVM {
  OrderVM();
  late int id;
  late String appUserID;
  late DateTime createdDate;
  late bool isPaid;
  DateTime? datePaid;
  late int orderStatusID;
  int? promotionID;
  double? promotionAmount;

  late String addressString;
  late String addressName;

  late List<OrderDetailVM> orderDetailVMs;
  late OrderStatusVM orderStatusVM;

  factory OrderVM.fromJson(Map<String, dynamic> json) =>
      _$OrderVMFromJson(json);
  Map<String, dynamic> toJson() => _$OrderVMToJson(this);
}

class OrderStatus {
  static const int DangChuanBi = 2;
  static const int DangGiaoHang = 3;
  static const int DaNhanHang = 4;
  static const int DaHuy = 5;
}
