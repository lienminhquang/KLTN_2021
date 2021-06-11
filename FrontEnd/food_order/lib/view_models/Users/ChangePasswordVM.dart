import 'package:json_annotation/json_annotation.dart';

part 'ChangePasswordVM.g.dart';

@JsonSerializable()
class ChangePasswordVM {
  String username;
  String newPassword;
  String oldPassword;

  ChangePasswordVM(this.username, this.newPassword, this.oldPassword);
  factory ChangePasswordVM.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordVMFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordVMToJson(this);
}
