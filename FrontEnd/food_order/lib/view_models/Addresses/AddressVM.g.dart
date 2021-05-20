// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressVM _$AddressVMFromJson(Map<String, dynamic> json) {
  return AddressVM()
    ..id = json['id'] as int
    ..appUserID = json['appUserID'] as String
    ..name = json['name'] as String
    ..addressString = json['addressString'] as String;
}

Map<String, dynamic> _$AddressVMToJson(AddressVM instance) => <String, dynamic>{
      'id': instance.id,
      'appUserID': instance.appUserID,
      'name': instance.name,
      'addressString': instance.addressString,
    };
