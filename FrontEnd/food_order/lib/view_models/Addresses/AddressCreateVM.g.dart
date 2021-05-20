// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressCreateVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressCreateVM _$AddressCreateVMFromJson(Map<String, dynamic> json) {
  return AddressCreateVM()
    ..appUserID = json['appUserID'] as String
    ..name = json['name'] as String
    ..addressString = json['addressString'] as String;
}

Map<String, dynamic> _$AddressCreateVMToJson(AddressCreateVM instance) =>
    <String, dynamic>{
      'appUserID': instance.appUserID,
      'name': instance.name,
      'addressString': instance.addressString,
    };
