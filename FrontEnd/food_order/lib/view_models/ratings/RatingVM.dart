import 'package:json_annotation/json_annotation.dart';

part 'RatingVM.g.dart';

@JsonSerializable()
class RatingVM {
  RatingVM();

  int orderID = 0;
  String userID = "";
  int foodID = 0;
  int star = 0;
  String comment = "";
  String userFullName = "";
  DateTime timeCreate = DateTime.now();

  factory RatingVM.fromJson(Map<String, dynamic> json) =>
      _$RatingVMFromJson(json);
  Map<String, dynamic> toJson() => _$RatingVMToJson(this);
}
