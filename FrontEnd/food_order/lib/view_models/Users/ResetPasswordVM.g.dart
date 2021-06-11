// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResetPasswordVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordVM _$ResetPasswordVMFromJson(Map<String, dynamic> json) {
  return ResetPasswordVM(
    json['username'] as String,
    json['newPassword'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordVMToJson(ResetPasswordVM instance) =>
    <String, dynamic>{
      'username': instance.username,
      'newPassword': instance.newPassword,
    };
