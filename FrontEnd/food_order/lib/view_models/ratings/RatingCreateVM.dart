import 'package:json_annotation/json_annotation.dart';

part 'RatingCreateVM.g.dart';

@JsonSerializable()
class RatingCreateVM {
  final int orderID;

  final int foodID;
  final int star;
  final String comment;
  RatingCreateVM(this.orderID, this.foodID, this.star, this.comment);

  factory RatingCreateVM.fromJson(Map<String, dynamic> json) =>
      _$RatingCreateVMFromJson(json);
  Map<String, dynamic> toJson() => _$RatingCreateVMToJson(this);
}
