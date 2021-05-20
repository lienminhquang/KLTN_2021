import 'package:json_annotation/json_annotation.dart';

part 'AddressVM.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressVM {
  AddressVM();
  late int id;
  late String appUserID;
  late String name;
  late String addressString;

  factory AddressVM.fromJson(Map<String, dynamic> json) =>
      _$AddressVMFromJson(json);
  Map<String, dynamic> toJson() => _$AddressVMToJson(this);
}
