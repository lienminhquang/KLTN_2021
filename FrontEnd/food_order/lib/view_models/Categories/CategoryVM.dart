import 'package:json_annotation/json_annotation.dart';

part 'CategoryVM.g.dart';

@JsonSerializable()
class CategoryVM {
  CategoryVM();

  int? id;
  String? name;
  String? description;

  factory CategoryVM.fromJson(Map<String, dynamic> json) =>
      _$CategoryVMFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryVMToJson(this);
}
