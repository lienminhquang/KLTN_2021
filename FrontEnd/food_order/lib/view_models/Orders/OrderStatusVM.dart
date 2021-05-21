import 'package:json_annotation/json_annotation.dart';

part 'OrderStatusVM.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderStatusVM {
  OrderStatusVM();
  late int id;
  late String name;
  late String description;

  factory OrderStatusVM.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusVMFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusVMToJson(this);
}
