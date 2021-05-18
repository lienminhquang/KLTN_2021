import 'package:json_annotation/json_annotation.dart';

part 'CartCreateVM.g.dart';

@JsonSerializable()
class CartCreateVM {
  CartCreateVM();
  String appUserId = "";
  int foodID = 0;
  int quantity = 0;

  factory CartCreateVM.fromJson(Map<String, dynamic> json) =>
      _$CartCreateVMFromJson(json);
  Map<String, dynamic> toJson() => _$CartCreateVMToJson(this);
}
