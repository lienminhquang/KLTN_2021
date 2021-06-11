// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePasswordVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordVM _$ChangePasswordVMFromJson(Map<String, dynamic> json) {
  return ChangePasswordVM(
    json['username'] as String,
    json['newPassword'] as String,
    json['oldPassword'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordVMToJson(ChangePasswordVM instance) =>
    <String, dynamic>{
      'username': instance.username,
      'newPassword': instance.newPassword,
      'oldPassword': instance.oldPassword,
    };
