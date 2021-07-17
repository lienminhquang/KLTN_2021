// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginVM _$LoginVMFromJson(Map<String, dynamic> json) {
  return LoginVM(
    json['username'] as String?,
    json['password'] as String?,
    json['rememberMe'] as bool?,
  )..deviceToken = json['deviceToken'] as String?;
}

Map<String, dynamic> _$LoginVMToJson(LoginVM instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'rememberMe': instance.rememberMe,
      'deviceToken': instance.deviceToken,
    };
