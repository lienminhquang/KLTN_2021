import 'package:json_annotation/json_annotation.dart';

part 'RegisterRequest.g.dart';

@JsonSerializable()
class RegisterRequest {
  String firstName;
  String lastName;
  String phoneNumber;
  String password;

  RegisterRequest(
      this.firstName, this.lastName, this.phoneNumber, this.password);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
