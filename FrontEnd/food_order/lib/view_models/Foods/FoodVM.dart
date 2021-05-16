import 'package:json_annotation/json_annotation.dart';

part 'FoodVM.g.dart';

@JsonSerializable()
class FoodVM {
  FoodVM(
      {this.id = -1,
      this.name = "",
      this.description = "",
      this.price = 0,
      this.count = 0,
      this.imagePath = ""});

  int id;
  String name;
  String description;
  double price;
  int count;
  String imagePath;

  factory FoodVM.fromJson(Map<String, dynamic> json) => _$FoodVMFromJson(json);
  Map<String, dynamic> toJson() => _$FoodVMToJson(this);
}
