import 'package:json_annotation/json_annotation.dart';

part 'RatingVM.g.dart';

@JsonSerializable()
class RatingVM {
  RatingVM();

  String appUserID = "";
  int foodID = 0;
  int star = 0;
  String comment = "";
  DateTime lastCreatedTime = DateTime.now();
  String userFullName = "";

  factory RatingVM.fromJson(Map<String, dynamic> json) =>
      _$RatingVMFromJson(json);
  Map<String, dynamic> toJson() => _$RatingVMToJson(this);
}
