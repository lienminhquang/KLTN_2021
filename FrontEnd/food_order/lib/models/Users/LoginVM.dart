import 'package:json_annotation/json_annotation.dart';

part 'LoginVM.g.dart';

@JsonSerializable()
class LoginVM {
  LoginVM(this.username, this.password, this.rememberMe);

  String? username;
  String? password;
  bool? rememberMe;

  factory LoginVM.fromJson(Map<String, dynamic> json) =>
      _$LoginVMFromJson(json);
  Map<String, dynamic> toJson() => _$LoginVMToJson(this);
}
