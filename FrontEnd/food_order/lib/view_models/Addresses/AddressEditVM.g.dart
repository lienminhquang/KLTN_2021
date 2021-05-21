// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressEditVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressEditVM _$AddressEditVMFromJson(Map<String, dynamic> json) {
  return AddressEditVM()
    ..id = json['id'] as int
    ..appUserID = json['appUserID'] as String
    ..name = json['name'] as String
    ..addressString = json['addressString'] as String;
}

Map<String, dynamic> _$AddressEditVMToJson(AddressEditVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appUserID': instance.appUserID,
      'name': instance.name,
      'addressString': instance.addressString,
    };
