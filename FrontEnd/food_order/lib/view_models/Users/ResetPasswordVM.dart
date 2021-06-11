import 'package:json_annotation/json_annotation.dart';

part 'ResetPasswordVM.g.dart';

@JsonSerializable()
class ResetPasswordVM {
  String username;
  String newPassword;
  // Todo: check OTP

  ResetPasswordVM(this.username, this.newPassword);

  factory ResetPasswordVM.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordVMFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordVMToJson(this);
}
