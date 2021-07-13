import 'package:json_annotation/json_annotation.dart';

part 'UserEditVM.g.dart';

@JsonSerializable()
class UserEditVM {
  String userID;

  String username;

  //public string FirstName { get; set; }

  String name;

  DateTime dob;

  String? email;

  UserEditVM(this.userID, this.username, this.name, this.dob, this.email);
  factory UserEditVM.fromJson(Map<String, dynamic> json) =>
      _$UserEditVMFromJson(json);
  Map<String, dynamic> toJson() => _$UserEditVMToJson(this);
}
