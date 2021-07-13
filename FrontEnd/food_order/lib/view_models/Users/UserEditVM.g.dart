// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEditVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEditVM _$UserEditVMFromJson(Map<String, dynamic> json) {
  return UserEditVM(
    json['userID'] as String,
    json['username'] as String,
    json['name'] as String,
    DateTime.parse(json['dob'] as String),
    json['email'] as String?,
  );
}

Map<String, dynamic> _$UserEditVMToJson(UserEditVM instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'name': instance.name,
      'dob': instance.dob.toIso8601String(),
      'email': instance.email,
    };
