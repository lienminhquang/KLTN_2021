import 'package:json_annotation/json_annotation.dart';

part 'UserVM.g.dart';

@JsonSerializable()
class UserVM {
  String id;
  String username;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String email;
  UserVM(this.id, this.username, this.firstName, this.lastName,
      this.dateOfBirth, this.email);

  factory UserVM.fromJson(Map<String, dynamic> json) => _$UserVMFromJson(json);
  Map<String, dynamic> toJson() => _$UserVMToJson(this);
}
