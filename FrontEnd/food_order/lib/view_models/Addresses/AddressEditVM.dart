import 'package:json_annotation/json_annotation.dart';

part 'AddressEditVM.g.dart';

@JsonSerializable()
class AddressEditVM {
  AddressEditVM();

  late int id;
  late String appUserID;
  late String name;
  late String addressString;

  factory AddressEditVM.fromJson(Map<String, dynamic> json) =>
      _$AddressEditVMFromJson(json);
  Map<String, dynamic> toJson() => _$AddressEditVMToJson(this);
}
