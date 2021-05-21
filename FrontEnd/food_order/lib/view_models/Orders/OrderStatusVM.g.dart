// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderStatusVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusVM _$OrderStatusVMFromJson(Map<String, dynamic> json) {
  return OrderStatusVM()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$OrderStatusVMToJson(OrderStatusVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
