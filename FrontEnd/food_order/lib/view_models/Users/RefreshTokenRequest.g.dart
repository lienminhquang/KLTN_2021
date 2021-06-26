// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RefreshTokenRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) {
  return RefreshTokenRequest(
    json['oldToken'] as String,
    json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$RefreshTokenRequestToJson(
        RefreshTokenRequest instance) =>
    <String, dynamic>{
      'oldToken': instance.oldToken,
      'refreshToken': instance.refreshToken,
    };
