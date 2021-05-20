import 'package:json_annotation/json_annotation.dart';

part 'AddressCreateVM.g.dart';

@JsonSerializable()
class AddressCreateVM {
  late String appUserID;
  late String name;
  late String addressString;
  AddressCreateVM();

  factory AddressCreateVM.fromJson(Map<String, dynamic> json) =>
      _$AddressCreateVMFromJson(json);
  Map<String, dynamic> toJson() => _$AddressCreateVMToJson(this);
}
